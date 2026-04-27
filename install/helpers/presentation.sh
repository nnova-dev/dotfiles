#!/bin/bash

# Affiche un titre d'étape stylé
print_step() {
    echo -e "\n${BOLD}${BLUE}==>${NC} ${BOLD}$1${NC}"
}

# Affiche un message de succès
print_success() {
    echo -e "${GREEN}  OK: $1${NC}"
}

# Affiche un avertissement
print_warning() {
    echo -e "${YELLOW}  ATTENTION: $1${NC}"
}

# Message d'erreur et arrêt du script
print_error() {
    echo -e "\n${RED}${BOLD}❌ ERREUR :${NC} $1"
    echo -e "${YELLOW}L'installation est arrêtée.${NC}"
    exit 1
}
