#!/bin/bash

# Hakemisto, josta haluat lukea .txt-tiedostot
DIRECTORY="."

# HTML-sivun nimi
HTML_FILE="index.html"

# Luodaan HTML-sivun alkuosa
echo "<!DOCTYPE html>" > "$HTML_FILE"
echo "<html>" >> "$HTML_FILE"
echo "<head>" >> "$HTML_FILE"
echo "  <title>Linkit .txt-tiedostoihin</title>" >> "$HTML_FILE"
echo "</head>" >> "$HTML_FILE"
echo "<body>" >> "$HTML_FILE"
echo "  <h2>Linkit .txt-tiedostoihin</h2>" >> "$HTML_FILE"
echo "  <ul>" >> "$HTML_FILE"

# Käydään läpi .txt-tiedostot hakemistossa
for file in "$DIRECTORY"/*.csv; do
  # Otetaan vain tiedostonimi ilman hakemistopolkua
  filename=$(basename -- "$file")
  # Luodaan linkki HTML-sivulle
  echo "    <li><a href=\"$filename\">$filename</a></li>" >> "$HTML_FILE"
done

# Luodaan HTML-sivun loppuosa
echo "  </ul>" >> "$HTML_FILE"
echo "</body>" >> "$HTML_FILE"
echo "</html>" >> "$HTML_FILE"

echo "HTML-sivu luotu: $HTML_FILE"