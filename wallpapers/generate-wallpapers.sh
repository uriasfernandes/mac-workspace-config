#!/bin/bash

OUTDIR="$HOME/Pictures/wallpapers"
mkdir -p "$OUTDIR"

WIDTH=5120
HEIGHT=2880

SAFE_X=160
SAFE_Y=60

FONT="/System/Library/Fonts/Supplemental/Arial Bold.ttf"

create_wallpaper () {

NAME=$1
COLOR=$2
FILE=$3

magick -size ${WIDTH}x${HEIGHT} gradient:"#0f172a-$COLOR" \
-gravity southwest \
-font "$FONT" \
-pointsize 120 \
-fill white \
-undercolor '#00000080' \
-annotate +${SAFE_X}+${SAFE_Y} "$NAME" \
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