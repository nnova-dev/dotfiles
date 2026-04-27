#!/bin/bash
finalize_koda() {
    print_step "Finitions de l'installation"
    # 1. Définir ZSH comme shell par défaut si ce n'est pas déjà fait
    if [ "$SHELL" != "/usr/bin/zsh" ]; then
        echo "   Changement du shell vers ZSH..."
        sudo chsh -s /usr/bin/zsh "$USER"
    fi
    
    # 3. Message final de bienvenue
    print_success "Koda OS est prêt à l'emploi !"
    echo -e "${BLUE}Redémarre ton terminal ou ta session pour appliquer tous les changements.${NC}"
}
