#!/bin/bash
# Script per contare gli aggiornamenti disponibili
apt update > /dev/null 2>&1
APT_UPD=$(apt list --upgradable 2>/dev/null | tail -n +2 | wc -l)

if command -v flatpak &> /dev/null; then
    FLATPAK_UPD=$(flatpak remote-ls --updates 2>/dev/null | wc -l)
else
    FLATPAK_UPD=0
fi

TOTALE=$((APT_UPD + FLATPAK_UPD))

# Restituisce i dati in formato JSON per l'app
echo "{\"total\": $TOTALE, \"apt\": $APT_UPD, \"flatpak\": $FLATPAK_UPD}"
