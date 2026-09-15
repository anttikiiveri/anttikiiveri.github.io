#!/usr/bin/env bash

if [ "$#" -ne 2 ]; then
    echo "Käyttö: $0 <csv-tiedosto> <rivimaara_per_osa>"
    exit 1
fi

TIEDOSTO="$1"
RIVIT="$2"

PERUSOSA="${TIEDOSTO%.*}"
PAATE="${TIEDOSTO##*.}"

TMP_PREFIX="$(mktemp -u _split_tmp_XXXXXX)"

split -l "$RIVIT" "$TIEDOSTO" "${TMP_PREFIX}_"

OSA=1
for pala in "${TMP_PREFIX}_"*; do
    [ -e "$pala" ] || continue
    UUSI_NIMI="${PERUSOSA}-osa-${OSA}.${PAATE}"
    mv "$pala" "$UUSI_NIMI"
    echo "Luotu: $UUSI_NIMI"
    ((OSA++))
done