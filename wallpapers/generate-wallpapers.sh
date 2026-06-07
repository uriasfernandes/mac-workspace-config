#!/bin/bash

OUTDIR="$HOME/Pictures/wallpapers"
mkdir -p "$OUTDIR"

WIDTH="${WIDTH:-2560}"
HEIGHT="${HEIGHT:-1080}"
TEXT_SCALE_PERCENT="${TEXT_SCALE_PERCENT:-100}"
TEXT_MARGIN_X="${TEXT_MARGIN_X:-0}"
TEXT_MARGIN_Y="${TEXT_MARGIN_Y:-0}"
TEXT_EDGE_PADDING="${TEXT_EDGE_PADDING:-6}"

scale_value () {
echo $(( $1 * TEXT_SCALE_PERCENT / 100 ))
}

# Safe area and text bounds are relative to the output resolution to avoid
# oversized labels when monitor resolution changes.
SAFE_X=$TEXT_MARGIN_X
SAFE_Y=$TEXT_MARGIN_Y
TEXT_MAX_WIDTH=$(scale_value $(( WIDTH / 7 )))
TEXT_MAX_HEIGHT=$(scale_value $(( HEIGHT / 14 )))
POINTSIZE_START=$(scale_value $(( HEIGHT / 13 )))
POINTSIZE_MIN=$(scale_value $(( HEIGHT / 55 )))

if [ "$POINTSIZE_START" -lt 48 ]; then POINTSIZE_START=48; fi
if [ "$POINTSIZE_MIN" -lt 18 ]; then POINTSIZE_MIN=18; fi

FONT="/System/Library/Fonts/Supplemental/Arial Bold.ttf"
STROKE_COLOR='#00000099'
STROKE_WIDTH=2

fit_pointsize () {

NAME=$1
POINTSIZE=$POINTSIZE_START

while [ "$POINTSIZE" -ge "$POINTSIZE_MIN" ]; do
	read -r TEXT_WIDTH TEXT_HEIGHT <<EOF
$(magick \
	-background none \
	-fill white \
	-stroke "$STROKE_COLOR" \
	-strokewidth "$STROKE_WIDTH" \
	-font "$FONT" \
	-pointsize "$POINTSIZE" \
	label:"$NAME" \
	-trim +repage \
	-format "%w %h" \
	info:)
EOF

	if [ "$TEXT_WIDTH" -le "$TEXT_MAX_WIDTH" ] && [ "$TEXT_HEIGHT" -le "$TEXT_MAX_HEIGHT" ]; then
		echo "$POINTSIZE"
		return
	fi

	POINTSIZE=$((POINTSIZE - 2))
done

echo "$POINTSIZE_MIN"

}

create_wallpaper () {

NAME=$1
COLOR=$2
FILE=$3
POINTSIZE=$(fit_pointsize "$NAME")

magick -size ${WIDTH}x${HEIGHT} gradient:"#0f172a-$COLOR" \
-gravity southwest \
\( \
	-background none \
	-fill white \
	-stroke "$STROKE_COLOR" \
	-strokewidth "$STROKE_WIDTH" \
	-font "$FONT" \
	-pointsize "$POINTSIZE" \
	label:"$NAME" \
	-trim +repage \
	-bordercolor none \
	-border "$TEXT_EDGE_PADDING" \
\) \
-geometry +${SAFE_X}+${SAFE_Y} \
-composite \
"$OUTDIR/$FILE"

echo "✔ criado: $OUTDIR/$FILE"

}

create_wallpaper "Pessoal" "#f97316" "1-pessoal.png"
create_wallpaper "Trabalho" "#2563eb" "2-trabalho.png"
create_wallpaper "FinOps" "#16a34a" "3-finops.png"
create_wallpaper "DevOps - Projeto K8S" "#7c3aed" "4-devops-k8s.png"
create_wallpaper "DevOps - Projeto Vault" "#eab308" "5-devops-vault.png"
create_wallpaper "DevOps - IA" "#06b6d4" "6-devops-ia.png"
create_wallpaper "Bot" "#ef4444" "7-bot.png"

echo ""
echo "🚀 Wallpapers gerados em $OUTDIR"
echo "📐 Resolução usada: ${WIDTH}x${HEIGHT}"
echo "🔠 Escala de texto: ${TEXT_SCALE_PERCENT}%"