#!/bin/bash
essid=$(nmcli -t -f active,NAME,type con show 2>/dev/null | grep 802-11-wireless | grep yes | cut -d: -f2)

if [ -n "$essid" ]; then
    echo "󰤨"
else
    echo "󰤮"
fi
