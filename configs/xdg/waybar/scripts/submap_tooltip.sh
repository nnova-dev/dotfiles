#!/usr/bin/env bash

# Récupère le nom de la submap active via hyprctl
# Note: 'hyprctl submap' retourne le nom de la submap active (ou "default")
SUBMAP=$(hyprctl submap)

# Si on est en mode par défaut, on ne renvoie rien pour ne pas polluer Waybar
if [[ "$SUBMAP" == "default" || -z "$SUBMAP" ]]; then
    exit 0
fi

case "$SUBMAP" in
    "󰐥")
        TOOLTIP="L: Verrouiller\nS: Veille\nR: Redémarrer\nP: Éteindre\nEsc: Retour"
        ;;
    "name")
        TOOLTIP="Esc: Retour"
        ;;
    *)
        TOOLTIP="Mode: $SUBMAP\nEsc: Retour"
        ;;
esac

# Sortie au format JSON pour le module custom de Waybar
printf '{"text": "%s", "tooltip": "%s", "class": "%s"}\n' "$SUBMAP" "$TOOLTIP" "$SUBMAP"
