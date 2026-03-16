#!/usr/bin/env python3
"""
generate_quran_json.py
Converts sourates_data.dart → assets/quran.json
Run from the project root: python3 tools/generate_quran_json.py
"""

import re
import json
import sys
from pathlib import Path


# ──────────────────────────────────────────────────────────────────────────────
# TOKENIZER
# ──────────────────────────────────────────────────────────────────────────────

def tokenize(source: str):
    """Tokenize a Dart source file, skipping comments and whitespace."""
    tokens = []
    pos = 0
    n = len(source)

    while pos < n:
        c = source[pos]

        # Whitespace
        if c in ' \t\n\r':
            pos += 1
            continue

        # Line comment
        if source[pos:pos+2] == '//':
            end = source.find('\n', pos)
            pos = (end + 1) if end != -1 else n
            continue

        # Block comment
        if source[pos:pos+2] == '/*':
            end = source.find('*/', pos + 2)
            pos = (end + 2) if end != -1 else n
            continue

        # Single-quoted string
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

        # Double-quoted string
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

        # Integer
        m = re.match(r'\d+', source[pos:])
        if m:
            tokens.append(('INT', int(m.group())))
            pos += len(m.group())
            continue

        # Identifier
        m = re.match(r'[a-zA-Z_][a-zA-Z0-9_]*', source[pos:])
        if m:
            tokens.append(('ID', m.group()))
            pos += len(m.group())
            continue

        # Punctuation / operators (anything else useful)
        if c in '()[]{}:,;=.<>!@#$%^&*+-/?|~':
            tokens.append(('PUNCT', c))
            pos += 1
            continue

        # Skip anything unrecognised (e.g. lone Unicode)
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
        """Consume a token if it matches, otherwise do nothing."""
        tok = self.peek()
        if tok and tok[0] == typ and (val is None or tok[1] == val):
            self.pos += 1
            return tok
        return None

    def parse_value(self):
        """Parse an INT or STR value."""
        tok = self.peek()
        if tok is None:
            raise ValueError("Unexpected end of tokens")
        if tok[0] in ('INT', 'STR'):
            self.pos += 1
            return tok[1]
        raise ValueError(f"Unexpected token in value position: {tok}")

    def parse_named_args(self):
        """
        Parse key: value pairs until closing ')'.
        Returns a dict of name → value.
        Handles nested lists for 'versets'.
        """
        fields = {}
        while True:
            tok = self.peek()
            if tok is None:
                break
            # Closing paren → end of constructor
            if tok[0] == 'PUNCT' and tok[1] == ')':
                self.consume()
                break
            # Skip trailing commas
            if tok[0] == 'PUNCT' and tok[1] == ',':
                self.consume()
                continue
            # Named argument: identifier ':'
            if tok[0] == 'ID':
                name = self.consume('ID')[1]
                self.consume('PUNCT', ':')
                next_tok = self.peek()
                # versets: [ ... ]
                if next_tok and next_tok[0] == 'PUNCT' and next_tok[1] == '[':
                    self.consume('PUNCT', '[')
                    versets = []
                    while True:
                        t = self.peek()
                        if t is None:
                            break
                        if t[0] == 'PUNCT' and t[1] == ']':
                            self.consume()
                            break
                        if t[0] == 'PUNCT' and t[1] == ',':
                            self.consume()
                            continue
                        if t[0] == 'ID' and t[1] == 'Verset':
                            versets.append(self.parse_verset())
                        else:
                            self.consume()  # skip unknown
                    fields[name] = versets
                else:
                    fields[name] = self.parse_value()
                self.maybe_consume('PUNCT', ',')
            else:
                # Skip unexpected token
                self.consume()
        return fields

    def parse_verset(self):
        """Parse Verset( ... ) → dict."""
        self.consume('ID', 'Verset')
        self.consume('PUNCT', '(')
        fields = self.parse_named_args()
        return {
            'numero':    fields.get('numero', 0),
            'arabe':     fields.get('arabe', ''),
            'phonetique': fields.get('phonetique', ''),
            'francais':  fields.get('francais', ''),
            'anglais':   fields.get('anglais', ''),
        }

    def parse_sourate(self):
        """Parse Sourate( ... ) → dict."""
        self.consume('ID', 'Sourate')
        self.consume('PUNCT', '(')
        fields = self.parse_named_args()
        return {
            'numero':        fields.get('numero', 0),
            'nomArabe':      fields.get('nomArabe', ''),
            'nomFrancais':   fields.get('nomFrancais', ''),
            'signification': fields.get('signification', ''),
            'nombreVersets': fields.get('nombreVersets', 0),
            'type':          fields.get('type', ''),
            'versets':       fields.get('versets', []),
        }

    def parse_sourates_list(self):
        """
        Scan forward until we find  sourates = [
        then parse every Sourate(...) inside.
        """
        # Fast-forward to `sourates = [`
        while self.pos < len(self.tokens):
            tok = self.peek()
            if tok and tok[0] == 'ID' and tok[1] == 'sourates':
                self.consume()
                eq = self.peek()
                if eq and eq[0] == 'PUNCT' and eq[1] == '=':
                    self.consume()
                    bracket = self.peek()
                    if bracket and bracket[0] == 'PUNCT' and bracket[1] == '[':
                        self.consume()
                        break
                # Not the one we want – keep scanning
            else:
                self.consume()
        else:
            raise ValueError("Could not find `sourates = [` in tokens")

        sourates = []
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
            if tok[0] == 'ID' and tok[1] == 'Sourate':
                sourates.append(self.parse_sourate())
            else:
                self.consume()

        return sourates


# ──────────────────────────────────────────────────────────────────────────────
# MAIN
# ──────────────────────────────────────────────────────────────────────────────

def main():
    dart_file = Path('lib/sourates_data.dart')
    if not dart_file.exists():
        print(f"ERROR: {dart_file} not found. Run this from the project root.", file=sys.stderr)
        sys.exit(1)

    print("Reading source …", file=sys.stderr)
    source = dart_file.read_text(encoding='utf-8')

    print("Tokenizing …", file=sys.stderr)
    tokens = tokenize(source)
    print(f"  → {len(tokens):,} tokens", file=sys.stderr)

    print("Parsing …", file=sys.stderr)
    parser = Parser(tokens)
    sourates = parser.parse_sourates_list()

    total_versets = sum(len(s['versets']) for s in sourates)
    print(f"  → {len(sourates)} sourates, {total_versets:,} versets", file=sys.stderr)

    out_path = Path('assets/quran.json')
    out_path.parent.mkdir(parents=True, exist_ok=True)
    output = json.dumps({"sourates": sourates}, ensure_ascii=False, indent=2)
    out_path.write_text(output, encoding='utf-8')

    size_kb = out_path.stat().st_size / 1024
    print(f"  → Written {out_path}  ({size_kb:.0f} KB)", file=sys.stderr)
    print("Done ✓", file=sys.stderr)


if __name__ == '__main__':
    main()
