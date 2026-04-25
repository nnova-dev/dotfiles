#!/bin/bash
awk -v sleep=0.5 '
BEGIN {
    while ((getline < "/proc/stat") > 0) {
        if ($1 ~ /^cpu/) {
            total = 0;
            for(i=2; i<=11; i++) total += $i;
            idle[$1] = $5;
            tot[$1] = total;
        }
    }
    close("/proc/stat");
    
    system("sleep " sleep);
    
    tooltip = "";
    overall = "";
    
    while ((getline < "/proc/stat") > 0) {
        if ($1 ~ /^cpu/) {
            total = 0;
            for(i=2; i<=11; i++) total += $i;
            diff_idle = $5 - idle[$1];
            diff_total = total - tot[$1];
            usage = (diff_total == 0) ? 0 : 100 * (diff_total - diff_idle) / diff_total;
            
            if ($1 == "cpu") {
                overall = sprintf("%.0f", usage);
            } else {
                core = substr($1, 4);
                if (tooltip != "") tooltip = tooltip "\\n";
                tooltip = tooltip "Core " core ": " sprintf("%.0f", usage) "%";
            }
        }
    }
    close("/proc/stat");
    
    printf "{\"text\": \"%s%%\", \"tooltip\": \"%s\"}\n", overall, tooltip;
}'
