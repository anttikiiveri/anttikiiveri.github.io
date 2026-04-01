#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# tee_hakemistosivu_v2.sh
# Luodaan HTML-sivu, joka listaa ./sanastot -kansion .csv-tiedostot
# Parannuksia: hakemiston tarkistus, tiedostonimien käsittely (välilyönnit/erikoismerkit),
# HTML-escaping ja data-file -attribuutin käyttö JavaScript-kutsussa.

# Hakemisto, josta halutaan lukea .csv-tiedostot
DIRECTORY="./sanastot"

# HTML-sivun nimi
HTML_FILE="sanakyselin.html"

if [ ! -d "$DIRECTORY" ]; then
  echo "Hakemistoa ei löydy: $DIRECTORY" >&2
  exit 1
fi

# Funktio HTML-escapingille
html_escape() {
  local s="$1"
  s=${s//&/&amp;}
  s=${s//</&lt;}
  s=${s//>/&gt;}
  s=${s//"/&quot;}
  s=${s//\'/&#39;}
  printf '%s' "$s"
}

# Haetaan csv-tiedostot uusimmasta vanhimpaan (macOS/BSD stat -f oletuksena)
# Tämä toimii macOS:ssa. Jos tarvitset Linux-yhteensopivuutta, voin lisätä vaihtoehdon.
mapfile -t files < <(
  find "$DIRECTORY" -maxdepth 1 -type f -name '*.csv' -print0 \
    | xargs -0 -n1 stat -f '%m	%N' 2>/dev/null \
    | sort -rn \
    | cut -f2-
)

# Luodaan HTML-sivun alkuosa
cat <<EOF > "$HTML_FILE"
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sanakyselin</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <style>
      body { font-family: system-ui, -apple-system, Arial, sans-serif; padding: 1rem; }
      ul { list-style: none; padding: 0; }
      li { margin: 0.4rem 0; }
    </style>
</head>
<body>
    <h2>Valitse tiedosto, jonka sanoja haluat harjoitella</h2>
    <ul>
EOF

if [ ${#files[@]} -eq 0 ]; then
  printf '    <li>Ei .csv-tiedostoja kansiossa: %s</li>\n' "$(html_escape "$DIRECTORY")" >> "$HTML_FILE"
else
  for file in "${files[@]}"; do
    # file voi sisältää koko polun; käytetään basenameia
    filename="$(basename -- "$file")"
    escaped="$(html_escape "$filename")"
    # Käytetään data-file -attribuuttia ja siirrytään siirryTestiin(this.dataset.file)
    printf '    <li><a href="#" data-file="%s" onclick="siirryTestiin(this.dataset.file)">%s</a></li>\n' "$escaped" "$escaped" >> "$HTML_FILE"
  done
fi

cat <<'EOF' >> "$HTML_FILE"
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
