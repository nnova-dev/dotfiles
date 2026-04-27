#!/bin/bash

# Handle menu click (Wofi power profile menu)
if [ "$1" = "menu" ]; then
    PROFILES="󰓅 Performance\n󰾆 Balanced\n󰌢 Power Saver"
    
    current_mode=$(powerprofilesctl get 2>/dev/null)
    
    if [ "$current_mode" = "performance" ]; then
        CURRENT="Performance"
    elif [ "$current_mode" = "balanced" ]; then
        CURRENT="Balanced"
    elif [ "$current_mode" = "power-saver" ]; then
        CURRENT="Power Saver"
    else
        CURRENT="Unknown"
    fi
    
    selected=$(echo -e "$PROFILES" | wofi -d -p "Mode ($CURRENT)" --lines 3 --width 250)
    
    case "$selected" in
        "󰓅 Performance") powerprofilesctl set performance ;;
        "󰾆 Balanced") powerprofilesctl set balanced ;;
        "󰌢 Power Saver") powerprofilesctl set power-saver ;;
    esac
    
    # Update waybar immediately
    pkill -RTMIN+8 waybar
    exit 0
fi

# =========================================================
# Status loop (JSON output for waybar)
# =========================================================

# Get current power profile via powerprofilesctl
mode="Unknown"
if command -v powerprofilesctl &> /dev/null && systemctl is-active --quiet power-profiles-daemon; then
    current_epp=$(powerprofilesctl get 2>/dev/null)
else
    current_epp=$(cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference 2>/dev/null)
fi

if [ "$current_epp" = "performance" ]; then
    mode="󰓅 Performance"
elif [ "$current_epp" = "balanced" ] || [ "$current_epp" = "balance_performance" ] || [ "$current_epp" = "default" ]; then
    mode="󰾆 Balanced"
elif [ "$current_epp" = "power-saver" ] || [ "$current_epp" = "power" ] || [ "$current_epp" = "balance_power" ]; then
    mode="󰌢 Power Saver"
else
    mode="$current_epp"
fi

# Battery logic using upower
bat_dev=$(upower -e | grep 'BAT' | head -n 1)
ac_dev=$(upower -e | grep -i 'AC' | head -n 1)

is_plugged=false
if [ -n "$ac_dev" ]; then
    ac_state=$(upower -i "$ac_dev" | awk '/online:/ {print $2}')
    if [ "$ac_state" = "yes" ]; then
        is_plugged=true
    fi
fi

if [ -z "$bat_dev" ]; then
    echo "{\"text\": \"\", \"tooltip\": \"AC Power\n\nMode: $mode\", \"percentage\": 100, \"class\": \"plugged\"}"
    exit 0
fi

info=$(upower -i "$bat_dev")
state=$(echo "$info" | awk '/state:/ {print $2}')
percentage=$(echo "$info" | awk '/percentage:/ {print int($2)}')
time_to_full=$(echo "$info" | awk '/time to full:/ {print $4" "$5}')
time_to_empty=$(echo "$info" | awk '/time to empty:/ {print $4" "$5}')
energy_rate=$(echo "$info" | awk '/energy-rate:/ {print $2" "$3}')

# Fallbacks for empty variables
[ -z "$energy_rate" ] && energy_rate="0 W"

# Determine icon based on percentage and state
idx=$(( percentage / 10 ))
if [ $idx -ge 10 ]; then idx=9; fi

icons_charging=("󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅")
icons_discharging=("󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")

# Logic to handle different states
if [ "$state" = "charging" ]; then
    icon="${icons_charging[$idx]}"
    tooltip="Battery: ${percentage}% (Charging)\nTime to full: ${time_to_full}\nDraw: ${energy_rate}\n\nMode: $mode"
elif [ "$state" = "fully-charged" ] || [ "$percentage" -eq 100 ]; then
    if [ "$is_plugged" = true ]; then
        icon=""
        tooltip="Battery: 100% (Plugged In)\n\nMode: $mode"
    else
        icon="󰁹"
        tooltip="Battery: 100% (Full)\n\nMode: $mode"
    fi
elif [ "$is_plugged" = true ]; then
    # It's plugged in, but not charging (e.g. pending-charge, idle)
    icon=""
    tooltip="Battery: ${percentage}% (Plugged In / Not Charging)\n\nMode: $mode"
else
    # Discharging
    icon="${icons_discharging[$idx]}"
    tooltip="Battery: ${percentage}%\nTime left: ${time_to_empty}\nDraw: ${energy_rate}\n\nMode: $mode"
fi

class=""
if [ "$is_plugged" = true ]; then
    class="plugged"
elif [ "$percentage" -le 10 ]; then
    class="critical"
elif [ "$percentage" -le 20 ]; then
    class="warning"
fi

# Output JSON (ONLY ICON in the text parameter, percentage moved to tooltip)
echo "{\"text\": \"${icon}\", \"tooltip\": \"$tooltip\", \"percentage\": $percentage, \"class\": \"$class\"}"
