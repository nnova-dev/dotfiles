#!/bin/bash

# Usage: install_packages_from_list "nom-du-fichier.packages"
install_packages_from_list() {
    local pkg_file="$KODA_INSTALL/packaging/$1"
    
    if [ ! -f "$pkg_file" ]; then
        print_error "Le fichier de paquets $1 est introuvable."
    fi
    print_step "Installation des paquets depuis $1"
    # Extraction des paquets (ignore les commentaires et lignes vides)
    local pkgs=($(grep -v '^#' "$pkg_file" | grep -v '^$'))
    if [ ${#pkgs[@]} -eq 0 ]; then
        print_warning "Aucun paquet trouvé dans $1."
        return
    fi
    # Installation via pacman
    sudo pacman -S --needed --noconfirm "${pkgs[@]}" || print_error "Échec de l'installation des paquets de $1."
    
    print_success "Paquets de $1 installés avec succès."
}
# Fonction principale du module packaging
install_all_packages() {
    # On installe la base d'abord
    install_packages_from_list "koda-base.packages"
    # Tu pourras ajouter ici des questions pour les autres listes plus tard
    # Exemple: read -p "Install dev tools? " ans && [ "$ans" == "y" ] && install_packages_from_list "koda-dev.packages"
}
