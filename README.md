# Debian Update Manager

Un gestore di aggiornamenti leggero e personalizzato per Debian (e derivate).
Sostituisce i vecchi strumenti di notifica integrando APT, Flatpak e il controllo della tray in un'unica interfaccia grafica moderna.

## Funzionalità
- **Tray Indicator**: Icona nella barra di sistema che cambia colore in base alla presenza di aggiornamenti (Blu: Controllo, Rosso: Aggiornamenti, Verde: OK).
- **GUI GTK4/Adw**: Interfaccia pulita che mostra quanti aggiornamenti APT e Flatpak sono disponibili.
- **Terminale Integrato**: L'aggiornamento viene eseguito in un terminale visibile, così puoi leggere tutte le conferme di `apt`.
- **Scorciatoie**: Accesso diretto a Synaptic e GNOME Software.
- **Zero Snap**: Pensato per chi usa solo APT e Flatpak.

## Dipendenze
Per eseguire l'app sono necessari i seguenti pacchetti:
```bash
sudo apt install python3 python3-gi gir1.2-gtk-4.0 gir1.2-adw-1 gir1.2-ayatanaappindicator3-0.1 policykit-1 libnotify-bin
