#!/bin/bash
set -e
PKG_NAME="debian-update-manager"
VERSION="1.1.3"
ARCH="all"
BUILD_DIR="build"
DIST_DIR="dist"
DEB_FILE="${DIST_DIR}/${PKG_NAME}_${VERSION}_${ARCH}.deb"

rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR/DEBIAN"
mkdir -p "$BUILD_DIR/usr/bin"
mkdir -p "$BUILD_DIR/usr/share/applications"
mkdir -p "$BUILD_DIR/usr/share/polkit-1/actions"
mkdir -p "$BUILD_DIR/etc/xdg/autostart"

# Installazione con i nuovi nomi univoci
install -m 755 src/update-manager "$BUILD_DIR/usr/bin/debian-update-gui"
install -m 755 src/update-helper.sh "$BUILD_DIR/usr/bin/debian-update-helper"
install -m 755 src/check-updates.sh "$BUILD_DIR/usr/bin/debian-check-updates"
install -m 755 src/update-tray "$BUILD_DIR/usr/bin/debian-update-tray"

install -m 644 data/applications/io.github.martino.UpdateManager.desktop "$BUILD_DIR/usr/share/applications/"
install -m 644 data/polkit-1/actions/io.github.martino.UpdateManager.policy "$BUILD_DIR/usr/share/polkit-1/actions/"
install -m 644 data/update-tray-autostart.desktop "$BUILD_DIR/etc/xdg/autostart/"

cat > "$BUILD_DIR/DEBIAN/control" <<CONTROL
Package: $PKG_NAME
Version: $VERSION
Section: utils
Priority: optional
Architecture: $ARCH
Depends: python3, python3-gi, gir1.2-gtk-4.0, gir1.2-adw-1, policykit-1 | pkexec, libnotify-bin
Maintainer: Martino <martino@localhost>
Description: GUI per la gestione degli aggiornamenti di sistema
 Gestisce aggiornamenti APT e Flatpak con interfaccia grafica e tray.
CONTROL

cat > "$BUILD_DIR/DEBIAN/postinst" <<'POST'
#!/bin/bash
if [ -x /usr/bin/update-desktop-database ]; then
    update-desktop-database -q /usr/share/applications || true
fi
exit 0
POST
chmod 755 "$BUILD_DIR/DEBIAN/postinst"

mkdir -p "$DIST_DIR"
dpkg-deb --build --root-owner-group "$BUILD_DIR" "$DEB_FILE"
rm -rf "$BUILD_DIR"
echo "Pacchetto creato: $DEB_FILE"
