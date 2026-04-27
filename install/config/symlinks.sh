#!/bin/bash

# Fonction de lien (on la garde telle quelle)
make_link() {
    local src="$1"
    local dst="$2"
    mkdir -p "$(dirname "$dst")"
    [ -e "$dst" ] || [ -L "$dst" ] && rm -rf "$dst"
    ln -s "$src" "$dst"
}
setup_koda_symlinks() {
    print_step "Déploiement modulaire des configurations"
    local home_dir="$KODA_PATH/configs/home"
    local xdg_dir="$KODA_PATH/configs/xdg"
    # 1. Tout ce qui est dans configs/home -> ~/
    if [ -d "$home_dir" ]; then
        find "$home_dir" -maxdepth 1 -mindepth 1 | while read -r src; do
            local name=$(basename "$src")
            make_link "$src" "$HOME/$name"
            
            # Partage du Shell avec Root
            if [[ "$name" == ".zshrc" || "$name" == ".bashrc" ]]; then
                sudo ln -sf "$src" "/root/$name"
            fi
            echo "   ✅ $name -> ~/"
        done
    fi

    if [ -d "$xdg_dir" ]; then
        find "$xdg_dir" -maxdepth 1 -mindepth 1 | while read -r src; do
            local name=$(basename "$src")
            make_link "$src" "$HOME/.config/$name"
            
            # Partage des dossiers d'apps avec Root
            sudo mkdir -p /root/.config
            sudo ln -sf "$src" "/root/.config/$name"
            echo "   ✅ $name -> ~/.config/"
        done
    fi
    print_success "Déploiement terminé avec succès."
}
