#!/bin/bash

# Hakemisto, josta haluat lukea .csv-tiedostot
DIRECTORY="./sanastot"

# HTML-sivun nimi
HTML_FILE="sanakyselin.html"

# Luodaan HTML-sivun alkuosa
cat <<EOF > "$HTML_FILE"
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sanakyselin</title>
</head>
<body>
    <h2>Valitse tiedosto, jonka sanoja haluat harjoitella</h2>
    <ul>
EOF

# Käydään läpi .csv-tiedostot hakemistossa
for file in "$DIRECTORY"/*.csv; do
    # Otetaan vain tiedostonimi ilman hakemistopolkua
    filename=$(basename -- "$file")
    # Luodaan suhteellinen linkki HTML-sivulle ja kutsutaan aloitaTesti-funktiota
    echo "    <li><a href=\"#\" onclick=\"siirryTestiin('$filename')\">$filename</a></li>" >> "$HTML_FILE"
done

# Luodaan HTML-sivun loppuosa
cat <<EOF >> "$HTML_FILE"
    </ul>
    <script>
        function siirryTestiin(tiedostoNimi) {
            console.log('Aloita testi:', tiedostoNimi);
            // Lisää tiedosto URL-parametriksi ja siirry aloitaTesti.html-sivulle
            window.location.href = 'testi_aloita_testi.html?tiedosto=' + encodeURIComponent(tiedostoNimi);
        }
    </script>
</body>
</html>
EOF

echo "HTML-sivu luotu: $HTML_FILE"
