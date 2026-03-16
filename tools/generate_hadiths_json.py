#!/usr/bin/env python3
"""
generate_hadiths_json.py
Converts hadith_screen.dart → assets/hadiths.json
Run from the project root: python3 tools/generate_hadiths_json.py
"""

import re
import json
import sys
from pathlib import Path


# ──────────────────────────────────────────────────────────────────────────────
# TOKENIZER  (identique au script Coran)
# ──────────────────────────────────────────────────────────────────────────────

def tokenize(source: str):
    tokens = []
    pos = 0
    n = len(source)

    while pos < n:
        c = source[pos]

        if c in ' \t\n\r':
            pos += 1
            continue

        if source[pos:pos+2] == '//':
            end = source.find('\n', pos)
            pos = (end + 1) if end != -1 else n
            continue

        if source[pos:pos+2] == '/*':
            end = source.find('*/', pos + 2)
            pos = (end + 2) if end != -1 else n
            continue

        if c == "'":
            pos += 1
            chars = []
            while pos < n:
                ch = source[pos]
                if ch == '\\':
                    pos += 1
                    if pos < n:
                        esc = source[pos]
                        mapping = {"'": "'", 'n': '\n', 't': '\t',
                                   'r': '\r', '\\': '\\', '"': '"'}
                        chars.append(mapping.get(esc, esc))
                        pos += 1
                elif ch == "'":
                    pos += 1
                    break
                else:
                    chars.append(ch)
                    pos += 1
            tokens.append(('STR', ''.join(chars)))
            continue

        if c == '"':
            pos += 1
            chars = []
            while pos < n:
                ch = source[pos]
                if ch == '\\':
                    pos += 1
                    if pos < n:
                        chars.append(source[pos])
                        pos += 1
                elif ch == '"':
                    pos += 1
                    break
                else:
                    chars.append(ch)
                    pos += 1
            tokens.append(('STR', ''.join(chars)))
            continue

        m = re.match(r'\d+', source[pos:])
        if m:
            tokens.append(('INT', int(m.group())))
            pos += len(m.group())
            continue

        m = re.match(r'[a-zA-Z_][a-zA-Z0-9_]*', source[pos:])
        if m:
            tokens.append(('ID', m.group()))
            pos += len(m.group())
            continue

        if c in '()[]{}:,;=.<>!@#$%^&*+-/?|~':
            tokens.append(('PUNCT', c))
            pos += 1
            continue

        pos += 1

    return tokens


# ──────────────────────────────────────────────────────────────────────────────
# PARSER
# ──────────────────────────────────────────────────────────────────────────────

class Parser:
    def __init__(self, tokens):
        self.tokens = tokens
        self.pos = 0

    def peek(self):
        return self.tokens[self.pos] if self.pos < len(self.tokens) else None

    def consume(self, typ=None, val=None):
        tok = self.tokens[self.pos]
        if typ and tok[0] != typ:
            raise ValueError(f"Expected type={typ} but got {tok} at pos={self.pos}")
        if val is not None and tok[1] != val:
            raise ValueError(f"Expected val={val!r} but got {tok} at pos={self.pos}")
        self.pos += 1
        return tok

    def maybe_consume(self, typ, val=None):
        tok = self.peek()
        if tok and tok[0] == typ and (val is None or tok[1] == val):
            self.pos += 1
            return tok
        return None

    def parse_named_args(self):
        """Parse key: value pairs until closing ')'."""
        fields = {}
        while True:
            tok = self.peek()
            if tok is None:
                break
            if tok[0] == 'PUNCT' and tok[1] == ')':
                self.consume()
                break
            if tok[0] == 'PUNCT' and tok[1] == ',':
                self.consume()
                continue
            if tok[0] == 'ID':
                name = self.consume('ID')[1]
                self.consume('PUNCT', ':')
                val_tok = self.peek()
                if val_tok and val_tok[0] in ('STR', 'INT'):
                    self.pos += 1
                    fields[name] = val_tok[1]
                else:
                    # skip unknown value
                    self.consume()
                self.maybe_consume('PUNCT', ',')
            else:
                self.consume()
        return fields

    def parse_hadith(self):
        """Parse HadithModel( ... ) → dict."""
        self.consume('ID', 'HadithModel')
        self.consume('PUNCT', '(')
        fields = self.parse_named_args()
        return {
            'arabe':                    fields.get('arabe', ''),
            'traduction':               fields.get('traduction', ''),
            'traductionEn':             fields.get('traductionEn', ''),
            'narrateur':                fields.get('narrateur', ''),
            'source':                   fields.get('source', ''),
            'phonetique':               fields.get('phonetique', ''),
            'categorie':                fields.get('categorie', ''),
            'explication':              fields.get('explication', ''),
            'explicationEn':            fields.get('explicationEn', ''),
            'applicationQuotidienne':   fields.get('applicationQuotidienne', ''),
            'applicationQuotidienneEn': fields.get('applicationQuotidienneEn', ''),
        }

    def parse_hadiths_list(self):
        """Scan to _hadiths = [ and parse every HadithModel(...)."""
        # Fast-forward to `_hadiths = [`
        while self.pos < len(self.tokens):
            tok = self.peek()
            if tok and tok[0] == 'ID' and tok[1] == '_hadiths':
                self.consume()
                eq = self.peek()
                if eq and eq[0] == 'PUNCT' and eq[1] == '=':
                    self.consume()
                    bracket = self.peek()
                    if bracket and bracket[0] == 'PUNCT' and bracket[1] == '[':
                        self.consume()
                        break
            else:
                self.consume()
        else:
            raise ValueError("Could not find `_hadiths = [` in tokens")

        hadiths = []
        while True:
            tok = self.peek()
            if tok is None:
                break
            if tok[0] == 'PUNCT' and tok[1] == ']':
                self.consume()
                break
            if tok[0] == 'PUNCT' and tok[1] == ',':
                self.consume()
                continue
            if tok[0] == 'ID' and tok[1] == 'HadithModel':
                hadiths.append(self.parse_hadith())
            else:
                self.consume()

        return hadiths

    def parse_categories_list(self):
        """Scan to _categories = [ and parse every string."""
        while self.pos < len(self.tokens):
            tok = self.peek()
            if tok and tok[0] == 'ID' and tok[1] == '_categories':
                self.consume()
                eq = self.peek()
                if eq and eq[0] == 'PUNCT' and eq[1] == '=':
                    self.consume()
                    bracket = self.peek()
                    if bracket and bracket[0] == 'PUNCT' and bracket[1] == '[':
                        self.consume()
                        break
            else:
                self.consume()
        else:
            return []  # not found, return empty

        categories = []
        while True:
            tok = self.peek()
            if tok is None:
                break
            if tok[0] == 'PUNCT' and tok[1] == ']':
                self.consume()
                break
            if tok[0] == 'PUNCT' and tok[1] == ',':
                self.consume()
                continue
            if tok[0] == 'STR':
                categories.append(self.consume('STR')[1])
            else:
                self.consume()

        return categories


# ──────────────────────────────────────────────────────────────────────────────
# MAIN
# ──────────────────────────────────────────────────────────────────────────────

def main():
    dart_file = Path('lib/hadith_screen.dart')
    if not dart_file.exists():
        print(f"ERROR: {dart_file} not found. Run from project root.", file=sys.stderr)
        sys.exit(1)

    print("Reading source …", file=sys.stderr)
    source = dart_file.read_text(encoding='utf-8')

    print("Tokenizing …", file=sys.stderr)
    tokens = tokenize(source)
    print(f"  → {len(tokens):,} tokens", file=sys.stderr)

    print("Parsing hadiths …", file=sys.stderr)
    parser = Parser(tokens)
    hadiths = parser.parse_hadiths_list()
    print(f"  → {len(hadiths)} hadiths", file=sys.stderr)

    print("Parsing categories …", file=sys.stderr)
    categories = parser.parse_categories_list()
    print(f"  → {len(categories)} categories: {categories}", file=sys.stderr)

    out_path = Path('assets/hadiths.json')
    out_path.parent.mkdir(parents=True, exist_ok=True)
    output = json.dumps(
        {"hadiths": hadiths, "categories": categories},
        ensure_ascii=False,
        indent=2,
    )
    out_path.write_text(output, encoding='utf-8')

    size_kb = out_path.stat().st_size / 1024
    print(f"  → Written {out_path}  ({size_kb:.0f} KB)", file=sys.stderr)
    print("Done ✓", file=sys.stderr)


if __name__ == '__main__':
    main()
