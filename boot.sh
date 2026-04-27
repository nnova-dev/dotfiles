#!/bin/bash

export KODA_ONLINE_INSTALL=true

ansi_art='
  ██╗  ██╗ ██████╗ ██████╗  █████╗ 
  ██║ ██╔╝██╔═══██╗██╔══██╗██╔══██╗
  █████╔╝ ██║   ██║██║  ██║███████║
  ██╔═██╗ ██║   ██║██║  ██║██╔══██║
  ██║  ██╗╚██████╔╝██████╔╝██║  ██║
  ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝'

clear
echo -e "\e[1;34m$ansi_art\e[0m" # Blue Bold
KODA_VER=$(cat ~/.local/share/koda/version 2>/dev/null || echo "dev")
echo -e "   --- Koda OS Bootstrap v$KODA_VER ---\n"

# Configuration du Repo
KODA_REF="${KODA_REF:-main}"
KODA_REPO="${KODA_REPO:-nnova-dev/dotfiles}" # REMPLACE PAR TON REPO REEL

echo -e "Mise à jour de pacman et installation de Git..."
sudo pacman -Syu --noconfirm --needed git

echo -e "\nClonage de Koda depuis : https://github.com/${KODA_REPO}.git"
rm -rf ~/.local/share/koda/
git clone --branch "${KODA_REF}" "https://github.com/${KODA_REPO}.git" ~/.local/share/koda/

if [[ -f ~/.local/share/koda/install.sh ]]; then
    echo -e "\nLancement de l'installateur Koda..."
    chmod +x ~/.local/share/koda/install.sh
    bash ~/.local/share/koda/install.sh
else
    echo -e "\n❌ Erreur : install.sh non trouvé dans le repo."
    exit 1
fi
