#!/bin/bash
install_packages_from_list() {
    # On calcule le chemin du dossier où se trouve ce fichier (install/packaging)
    local current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local pkg_file="$current_dir/$1"
    
    if [ ! -f "$pkg_file" ]; then
        print_error "Le fichier de paquets $1 est introuvable dans $current_dir"
    fi
    print_step "Installation des paquets depuis $1"
    
    # On extrait les paquets en ignorant les commentaires et les lignes vides
    local pkgs=($(grep -v '^#' "$pkg_file" | grep -v '^$'))
    if [ ${#pkgs[@]} -eq 0 ]; then
        print_warning "Aucun paquet trouvé dans $1."
        return
    fi
    sudo pacman -S --needed --noconfirm "${pkgs[@]}" || print_error "Échec de l'installation."
    
    print_success "Paquets de $1 installés."
}
install_all_packages() {
    install_packages_from_list "koda-base.packages"
}
