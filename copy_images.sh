#!/bin/bash
# Script pour copier les images Pexels téléchargées vers le dossier assets/modules
# Exécuter depuis le terminal : bash copy_images.sh

DOWNLOADS=~/Downloads
DEST="$(dirname "$0")/assets/modules"

declare -A IMAGES=(
  ["8522572"]="module_coran.jpg"
  ["7847282"]="module_hadith.jpg"
  ["12342693"]="module_children.jpg"
  ["20785789"]="module_dhikr.jpg"
  ["4463896"]="module_learning.jpg"
  ["273015"]="module_journal.jpg"
  ["12716195"]="module_community.jpg"
)

echo "📂 Copie des images Pexels vers $DEST"
echo ""

for ID in "${!IMAGES[@]}"; do
  DEST_NAME="${IMAGES[$ID]}"
  # Cherche un fichier contenant l'ID dans Downloads
  SRC=$(find "$DOWNLOADS" -maxdepth 1 -name "*${ID}*" | head -1)
  if [ -n "$SRC" ]; then
    cp "$SRC" "$DEST/$DEST_NAME"
    echo "✅  $DEST_NAME  ←  $(basename "$SRC")"
  else
    echo "❌  $DEST_NAME  —  fichier introuvable (ID: $ID)"
  fi
done

echo ""
echo "✨ Terminé ! Relancez l'app Flutter pour voir les nouvelles images."
