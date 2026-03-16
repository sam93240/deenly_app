#!/usr/bin/env python3
"""
download_audio.py
Télécharge les MP3 Mishary Alafasy (128kbps) depuis EveryAyah.com.

Pack 1 — 20 sourates courtes (apprentissage Juz Amma + Al-Fatiha) : 140 fichiers
Pack 2 — 5 grandes sourates (Al-Baqarah, Al-Kahf, Ya-Sin, Ar-Rahman, Al-Mulk) : 587 fichiers
Total                                                                             : 727 fichiers

Usage :
    python3 download_audio.py          ← télécharge tout (packs 1 + 2)

Les fichiers sont placés dans : assets/audio/alafasy/
Convention de nommage : SSS_AAA.mp3  (ex: 001_001.mp3, 002_286.mp3)
Les fichiers déjà présents sont ignorés (reprise possible après interruption).
"""

import os
import time
import urllib.request

BASE_URL = "https://everyayah.com/data/Alafasy_128kbps/"
OUTPUT_DIR = os.path.join(os.path.dirname(__file__), "assets", "audio", "alafasy")

# ── Pack 1 : 20 sourates courtes (apprentissage) ──────────────────────────────
SURAHS_SHORT = {
    1:   7,   # Al-Fatiha
    95:  8,   # At-Tin
    96:  19,  # Al-Alaq
    97:  5,   # Al-Qadr
    98:  8,   # Al-Bayyina
    99:  8,   # Az-Zalzala
    100: 11,  # Al-Adiyat
    101: 11,  # Al-Qari'ah
    102: 8,   # At-Takathur
    103: 3,   # Al-Asr
    104: 9,   # Al-Humaza
    105: 5,   # Al-Fil
    106: 4,   # Quraysh
    107: 7,   # Al-Ma'un
    108: 3,   # Al-Kawthar
    109: 6,   # Al-Kafirun
    110: 3,   # An-Nasr
    112: 4,   # Al-Ikhlas
    113: 5,   # Al-Falaq
    114: 6,   # An-Nas
}

# ── Pack 2 : 5 grandes sourates ───────────────────────────────────────────────
SURAHS_LONG = {
    2:   286,  # Al-Baqarah
    18:  110,  # Al-Kahf
    36:  83,   # Ya-Sin
    55:  78,   # Ar-Rahman
    67:  30,   # Al-Mulk
}

# Fusion des deux packs — modifier ici pour choisir ce qu'on télécharge
SURAHS = {**SURAHS_SHORT, **SURAHS_LONG}

def download():
    os.makedirs(OUTPUT_DIR, exist_ok=True)

    total   = sum(SURAHS.values())
    done    = 0
    skipped = 0
    errors  = []

    print(f"📥  Téléchargement de {total} fichiers audio vers {OUTPUT_DIR}\n")

    for surah, ayah_count in sorted(SURAHS.items()):
        for ayah in range(1, ayah_count + 1):
            filename_src  = f"{surah:03d}{ayah:03d}.mp3"       # EveryAyah : 001001.mp3
            filename_dest = f"{surah:03d}_{ayah:03d}.mp3"      # Notre conv : 001_001.mp3
            dest_path     = os.path.join(OUTPUT_DIR, filename_dest)

            # Sauter si déjà téléchargé
            if os.path.exists(dest_path) and os.path.getsize(dest_path) > 0:
                skipped += 1
                done    += 1
                print(f"  ✓ {filename_dest} (déjà présent)")
                continue

            url = BASE_URL + filename_src
            try:
                urllib.request.urlretrieve(url, dest_path)
                done += 1
                print(f"  ↓ {filename_dest}  [{done}/{total}]")
                time.sleep(0.15)  # pause légère pour ne pas surcharger le serveur
            except Exception as e:
                errors.append(filename_dest)
                print(f"  ✗ {filename_dest}  ERREUR : {e}")

    print(f"\n{'='*50}")
    print(f"✅  Terminé : {done - len(errors)}/{total} fichiers téléchargés")
    if skipped:
        print(f"⏭️   Ignorés (déjà présents) : {skipped}")
    if errors:
        print(f"❌  Erreurs ({len(errors)}) : {', '.join(errors)}")
    print(f"{'='*50}")

if __name__ == "__main__":
    download()
