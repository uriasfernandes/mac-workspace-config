#!/bin/bash

OUTDIR="$HOME/Pictures/wallpapers"
mkdir -p "$OUTDIR"

WIDTH=2048
HEIGHT=1280

SAFE_X=0
SAFE_Y=0
TEXT_MAX_WIDTH=560
TEXT_MAX_HEIGHT=92
POINTSIZE_START=160
POINTSIZE_MIN=28

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