#!/bin/bash
connected=$(bluetoothctl devices Connected 2>/dev/null | wc -l)
if [ "$connected" -gt 0 ]; then
    echo "󰂱"
else
    echo "󰂲"
fi
