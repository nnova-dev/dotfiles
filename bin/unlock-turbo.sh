#!/bin/bash
# Charge le module MSR
modprobe msr
# Force le Turbo Boost sur tous les coeurs
wrmsr -a 0x1a0 0x850089
