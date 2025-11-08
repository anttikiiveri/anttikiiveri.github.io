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

# Käydään läpi .csv-tiedostot uusimmasta vanhimpaan
for file in $(ls -t "$DIRECTORY"/*.csv); do
    filename=$(basename -- "$file")
    echo "    <li><a href=\"#\" onclick=\"siirryTestiin('$filename')\">$filename</a></li>" >> "$HTML_FILE"
done

# Luodaan HTML-sivun loppuosa
cat <<EOF >> "$HTML_FILE"
    </ul>
    <script>
        function siirryTestiin(tiedostoNimi) {
            console.log('Aloita testi:', tiedostoNimi);
            window.location.href = 'aloita_testi.html?tiedosto=' + encodeURIComponent(tiedostoNimi);
        }
    </script>
</body>
</html>
EOF

echo "HTML-sivu luotu: $HTML_FILE"
