#!/bin/bash
free -b | awk '/^Mem:/ {
    used = $3
    total = $2
    pct = (used / total) * 100
    used_gb = used / (1024^3)
    total_gb = total / (1024^3)
    printf "{\"text\": \"%.0f%%\", \"tooltip\": \"RAM: %.2fGb / %.2fGb\"}\n", pct, used_gb, total_gb
}'