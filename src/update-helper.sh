#!/bin/bash
# Helper per Update Manager - Eseguito come root tramite pkexec

echo "=== AGGIORNAMENTO APT ==="
apt update
apt upgrade
apt autoremove --purge
apt autoclean

if command -v flatpak &> /dev/null; then
    echo -e "\n=== AGGIORNAMENTO FLATPAK ==="
    flatpak update
    flatpak uninstall --unused
else
    echo -e "\nFlatpak non installato, salto."
fi

echo -e "\n=== AGGIORNAMENTO COMPLETATO ==="
exit 0
