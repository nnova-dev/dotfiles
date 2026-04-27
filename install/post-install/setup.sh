#!/bin/bash

finalize_koda() {
    print_step "Finitions de l'installation"
    # 1. Installation de Oh My Zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "   Installation de Oh My Zsh..."
        # On utilise le script officiel de Oh My Zsh en mode non-interactif
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        
        # Le script d'install de OMZ crée un nouveau .zshrc, on doit remettre le nôtre
        setup_koda_symlinks # On relance la fonction des liens pour être sûr
    fi
    # 2. Activation du service Ly (Display Manager)
    # if pacman -Qs ly > /dev/null; then
    #     echo "   Activation du service Ly..."
    #     sudo systemctl enable ly@tty2.service
    # fi
    # 3. Changement du shell
    [ "$SHELL" != "/usr/bin/zsh" ] && sudo chsh -s /usr/bin/zsh "$USER"
    cp "$KODA_PATH/version" "$HOME/.config/koda-version"
    print_success "Finitions terminées."
}
