#!/bin/sh

# Gintvilė Bergerytė, Bioinformatika 3 kursas
# Užduotis yra skirta molekulių vaizdavimui, naudojantis Jmol


# Paleidimas:
#    $0 "helixAlpha" input.pdb output.png
#    $0 "sheet" input.pdb output.png
#    $0 "helixAlpha" input.pdb output.png

set -ue

if[ $# == 3 ]; then
  SELECTED="$1"
  INPUT_FILE="$2"
  OUTPUT_FILE="$3"
  ROTATION="[[0 0 0]
             [0 0 0]
             [0 0 0] ]"
elif[ $1 eq "-r" ] && [ $# == 3]; then
  ROTATION="$2"
  SELECTED="$3"
  INPUT_FILE="$4"
  OUTPUT_FILE="$5"
fi

jmol \
    --nodisplay \
    --script - <<EOF
select ${SELECTED} # !!!! might be troublesome
load ${INPUT_FILE}
select all
wireframe off
cpk off
wireframe on
set defaultColors Jmol
# Naudojamos tik beta klostės, nes paprstai alfa grandinės
# neprideda stabilumo modeliui ir sujaukia struktūrą
select sheet
calculate hbonds
hbonds 1.0 #ar reikia?
set hbonds solid #ar reikia?
set hbonds backbone #ar reikia?
rotate "${ROTATION}"
write png "${OUTPUT_FILE}"
EOF

##     --write PNG:${OUTPUT_FILE}
