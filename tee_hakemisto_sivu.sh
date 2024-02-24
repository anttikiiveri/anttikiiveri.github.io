#!/bin/bash

# Hakemisto, josta haluat lukea .csv-tiedostot
DIRECTORY="./sanastot"

# HTML-sivun nimi
HTML_FILE="index.html"

# Luodaan HTML-sivun alkuosa
echo "<!DOCTYPE html>" > "$HTML_FILE"
echo "<html>" >> "$HTML_FILE"
echo "<head>" >> "$HTML_FILE"
echo "  <title>Linkit .csv-tiedostoihin</title>" >> "$HTML_FILE"
echo "</head>" >> "$HTML_FILE"
echo "<body>" >> "$HTML_FILE"
echo "  <h2>Linkit .csv-tiedostoihin</h2>" >> "$HTML_FILE"
echo "  <ul>" >> "$HTML_FILE"

# Käydään läpi .csv-tiedostot hakemistossa
for file in "$DIRECTORY"/*.csv; do
  # Otetaan vain tiedostonimi ilman hakemistopolkua
  filename=$(basename -- "$file")
  # Luodaan suhteellinen linkki HTML-sivulle
  echo "    <li><a href=\"https://anttikiiveri.github.io/$DIRECTORY/$filename\">$filename</a></li>" >> "$HTML_FILE"
done

# Luodaan HTML-sivun loppuosa
echo "  </ul>" >> "$HTML_FILE"
echo "</body>" >> "$HTML_FILE"
echo "</html>" >> "$HTML_FILE"

echo "HTML-sivu luotu: $HTML_FILE"
