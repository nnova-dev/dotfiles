#!/bin/bash

# install.sh - Le Chef d'Orchestre de Koda OS
# 1. Sécurité
set -eEo pipefail

# 2. Variables d'environnement pour toute la session d'installation
export KODA_PATH="$HOME/.local/share/koda"
export KODA_INSTALL="$KODA_PATH/install"
export KODA_CONFIGS="$KODA_PATH/configs"

# 3. CHARGEMENT DES MODULES (On apprend les fonctions au système)
# On source les all.sh qui vont eux-mêmes sourcer les fichiers de fonctions
source "$KODA_INSTALL/helpers/all.sh"
source "$KODA_INSTALL/packaging/all.sh"
source "$KODA_INSTALL/config/all.sh"
source "$KODA_INSTALL/post-install/all.sh"

# --- DEBUT DE L'EXÉCUTION ---
clear

# Affichage du logo
if [ -f "$KODA_PATH/logo.txt" ]; then
    echo -e "${BLUE}$(cat "$KODA_PATH/logo.txt")${NC}"
fi
echo -e "\n${BOLD}${BLUE}   --- BIENVENUE SUR KODA OS ---   ${NC}\n"

# Etape 1 : Packaging
# On appelle la fonction définie dans packaging/pacman.sh
install_all_packages

# Etape 2 : Symlinks
# On appelle la fonction définie dans config/symlinks.sh
setup_koda_symlinks

# Etape 3 : Finalisation
# On appelle la fonction définie dans post-install/setup.sh
finalize_koda
echo -e "\n${GREEN}${BOLD}✨ Koda OS est maintenant prêt !${NC}"
echo -e "Veuillez redémarrer votre session pour profiter de votre environnement."
