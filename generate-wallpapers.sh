#!/bin/bash

WIDTH=3840
HEIGHT=2160

FONT="/System/Library/Fonts/Supplemental/Arial Bold.ttf"

create_wallpaper () {

NAME=$1
COLOR=$2
FILE=$3

magick -size ${WIDTH}x${HEIGHT} gradient:"#0f172a-$COLOR" \
-gravity southwest \
-font "$FONT" \
-pointsize 10 \
-fill white \
-undercolor '#00000080' \
-annotate +200+200 "$NAME" \
"$FILE"

echo "✔ criado: $FILE"

}

create_wallpaper "Pessoal" "#f97316" "1-pessoal.png"
create_wallpaper "Trabalho" "#2563eb" "2-trabalho.png"
create_wallpaper "FinOps" "#16a34a" "3-finops.png"
create_wallpaper "DevOps - Projeto K8S" "#7c3aed" "4-devops-k8s.png"
create_wallpaper "DevOps - Projeto Vault" "#eab308" "5-devops-vault.png"
create_wallpaper "DevOps - IA" "#06b6d4" "6-devops-ia.png"

echo ""
echo "🚀 Wallpapers gerados em ~/wallpapers"