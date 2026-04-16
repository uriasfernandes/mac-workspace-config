#!/bin/bash

WIDTH=5120
HEIGHT=2880

SAFE_X=160
SAFE_Y=100

FONT="/System/Library/Fonts/Supplemental/Arial Bold.ttf"

generate_wallpaper () {

NAME=$1
COLOR=$2
FILE=$3

magick -size ${WIDTH}x${HEIGHT} gradient:"#0f172a-$COLOR" -gravity southwest -font "$FONT" -pointsize 120 -fill white -undercolor '#00000060' -annotate +${SAFE_X}+${SAFE_Y} "$NAME" "$FILE"

}

generate_wallpaper "Pessoal" "#f97316" "1-pessoal.png"
generate_wallpaper "Trabalho" "#2563eb" "2-trabalho.png"
generate_wallpaper "FinOps" "#16a34a" "3-finops.png"
generate_wallpaper "DevOps - Projeto K8S" "#7c3aed" "4-devops-k8s.png"
generate_wallpaper "DevOps - Projeto Vault" "#eab308" "5-devops-vault.png"
generate_wallpaper "DevOps - IA" "#06b6d4" "6-devops-ia.png"

echo "Wallpapers generated."
