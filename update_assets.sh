#!/bin/zsh
# update_assets.sh — recopie dans le site les visuels produits par les autres lots
# (dist/brand et dist/media/<theme>/png), sous les noms déjà utilisés par index.html.
# Usage : ./update_assets.sh   (idempotent ; ne supprime rien ; une source absente = fichier actuel conservé)
set -u
SITE=${0:A:h}; DIST=${SITE:h}; BR=$DIST/brand; MD=$DIST/media
n=0
have(){ command -v $1 >/dev/null 2>&1 }
say(){ echo "  ${1#$DIST/} -> ${2#$SITE/}"; n=$((n+1)) }
# copie simple : dest  source1 [source2 ...] (la 1re source existante gagne)
pick(){ local d=$1; shift; for s in "$@"; do [[ -f $s ]] && { cp -f $s $d; say $s $d; return 0 }; done; return 1 }
# image -> webp : dest.webp largeur source1 [source2 ...]
webp(){ local d=$1 w=$2; shift 2; for s in "$@"; do [[ -f $s ]] || continue
  if have cwebp; then cwebp -quiet -q 80 -resize $w 0 $s -o $d; else magick $s -resize ${w}x -quality 80 $d; fi
  say $s $d; return 0; done; return 1 }

echo "== identité ($BR)"
pick $SITE/img/logo.svg  $BR/icon.svg $BR/logo.svg
pick $SITE/favicon.svg   $BR/icon.svg $BR/logo.svg
pick $SITE/img/og.png    $BR/banners/og-image-1200x630.png $BR/og.png
if have magick && [[ -f $SITE/favicon.svg ]]; then
  magick -background none -density 384 $SITE/favicon.svg -filter point -resize 32x32 $SITE/favicon.png 2>/dev/null && say favicon.svg $SITE/favicon.png
  magick -background '#0b0d14' -density 1600 $SITE/favicon.svg -filter point -resize 160x160 -gravity center -extent 180x180 $SITE/apple-touch-icon.png 2>/dev/null && say favicon.svg $SITE/apple-touch-icon.png
fi

echo "== galerie ($MD)"
J=$MD/jungle/png; N=$MD/neoncity/png
webp $SITE/img/jungle-day-16x9.webp        1600 $J/jungle_1920x1080_h12.png
webp $SITE/img/jungle-dusk-16x9.webp       1600 $J/jungle_1920x1080_h18.5.png
webp $SITE/img/jungle-dusk-32x9.webp       2000 $J/jungle_5120x1440_h18.5.png
webp $SITE/img/jungle-night-32x9.webp      2000 $J/jungle_5120x1440_h23.png
webp $SITE/img/neoncity-dusk-16x9.webp     1600 $N/neoncity_1920x1080_h18.5.png
webp $SITE/img/neoncity-night-16x9.webp    1600 $N/neoncity_1920x1080_h23.png
webp $SITE/img/neoncity-rain-16x9.webp     1600 $N/neoncity_1920x1080_h23_pluie.png $N/neoncity_1920x1080_h23_rain*.png(N)
webp $SITE/img/neoncity-night-21x9.webp    1600 $N/neoncity_3440x1440_h23.png $N/neoncity_2560x1080_h23*.png(N)
webp $SITE/img/neoncity-fireworks-32x9.webp 2000 $N/neoncity_5120x1440_*fireworks*.png(N) $N/neoncity_5120x1440_*fx*.png(N)

echo "== $n fichier(s) mis à jour."
echo "Ensuite : vérifier la page, puis git add <fichiers modifiés> && git commit -m 'Mise à jour visuels'"
