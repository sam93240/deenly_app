#!/usr/bin/env python3
"""
Télécharge les sourates manquantes (Mishary Alafasy 128kbps)
depuis everyayah.com vers assets/audio/alafasy/

Usage (depuis le dossier racine du projet Flutter) :
    python3 download_missing_audio.py

Les fichiers déjà présents sont ignorés (pas re-téléchargés).
"""

import os
import time
import urllib.request
import urllib.error

# ── Dossier de destination ────────────────────────────────────────
DEST = os.path.join(os.path.dirname(__file__), "assets", "audio", "alafasy")
BASE_URL = "https://everyayah.com/data/Alafasy_128kbps/{surah:03d}{ayah:03d}.mp3"

# ── Nombre de versets par sourate ─────────────────────────────────
QURAN_SIZES = {
    56:  96,   # Al-Waqi'a
    78:  40,   # An-Naba
    79:  46,   # An-Nazi'at
    80:  42,   # Abasa
    81:  29,   # At-Takwir
    82:  19,   # Al-Infitar
    83:  36,   # Al-Mutaffifin
    84:  25,   # Al-Inshiqaq
    85:  22,   # Al-Buruj
    86:  17,   # At-Tariq
    87:  19,   # Al-A'la
    88:  26,   # Al-Ghashiyah
    89:  30,   # Al-Fajr
    90:  20,   # Al-Balad
    91:  15,   # Ash-Shams
    92:  21,   # Al-Layl
    93:  11,   # Ad-Duha
    94:   8,   # Ash-Sharh
    111:  5,   # Al-Masad (Al-Lahab)
}


def download():
    os.makedirs(DEST, exist_ok=True)

    total   = sum(QURAN_SIZES.values())
    done    = 0
    skipped = 0
    failed  = []

    for surah, num_ayahs in sorted(QURAN_SIZES.items()):
        print(f"\n── Sourate {surah:03d} ({num_ayahs} versets) ─────────────────")
        for ayah in range(1, num_ayahs + 1):
            filename = f"{surah:03d}_{ayah:03d}.mp3"
            dest_path = os.path.join(DEST, filename)

            if os.path.exists(dest_path) and os.path.getsize(dest_path) > 1000:
                skipped += 1
                done    += 1
                print(f"  ✓ {filename} (déjà présent)", end="\r")
                continue

            url = BASE_URL.format(surah=surah, ayah=ayah)
            for attempt in range(3):
                try:
                    urllib.request.urlretrieve(url, dest_path)
                    size_kb = os.path.getsize(dest_path) // 1024
                    done += 1
                    print(f"  ↓ {filename}  {size_kb} Ko  [{done}/{total}]")
                    time.sleep(0.05)   # 50 ms entre requêtes — respecte le CDN
                    break
                except urllib.error.HTTPError as e:
                    if attempt == 2:
                        print(f"  ✗ {filename} — Erreur HTTP {e.code}")
                        failed.append(filename)
                    else:
                        time.sleep(1)
                except Exception as e:
                    if attempt == 2:
                        print(f"  ✗ {filename} — {e}")
                        failed.append(filename)
                    else:
                        time.sleep(1)

    print("\n" + "="*50)
    print(f"✅ Terminé : {done}/{total} fichiers")
    if skipped:
        print(f"   {skipped} déjà présents, ignorés")
    if failed:
        print(f"   {len(failed)} échecs : {failed[:10]}")
    else:
        print("   0 échec — tous les fichiers sont disponibles !")
    print(f"\nFichiers dans : {DEST}")
    print("\nProchaine étape :")
    print("  git add assets/audio/alafasy/")
    print("  git commit -m 'feat(audio): ajouter sourates manquantes Alafasy'")
    print("  git push origin main")


if __name__ == "__main__":
    download()
