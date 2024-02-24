#!/bin/bash

# Hakemisto, josta haluat lukea .csv-tiedostot
DIRECTORY="./sanastot"

# HTML-sivun nimi
HTML_FILE="index.html"

# Luodaan HTML-sivun alkuosa
cat <<EOF > "$HTML_FILE"
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Linkit .csv-tiedostoihin</title>
</head>
<body>
    <h2>Linkit .csv-tiedostoihin</h2>
    <ul>
EOF

# Käydään läpi .csv-tiedostot hakemistossa
for file in "$DIRECTORY"/*.csv; do
    # Otetaan vain tiedostonimi ilman hakemistopolkua
    filename=$(basename -- "$file")
    # Luodaan suhteellinen linkki HTML-sivulle ja kutsutaan aloitaTesti-funktiota
    echo "    <li><a href=\"#\" onclick=\"aloitaTesti('$filename')\">$filename</a></li>" >> "$HTML_FILE"
done

# Luodaan HTML-sivun loppuosa
cat <<EOF >> "$HTML_FILE"
    </ul>
    <script>
        function aloitaTesti(tiedostoNimi) {
            console.log('Aloita testi:', tiedostoNimi);
            // Voit lisätä haluamasi toiminnallisuuden tässä vaiheessa
        }
    </script>
</body>
</html>
EOF

echo "HTML-sivu luotu: $HTML_FILE"
