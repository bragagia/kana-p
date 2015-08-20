# Maintainer: Mathias Bragagia <youremail@domain.com>
pkgname=kana-p-dev
pkgver=0.0.4
pkgrel=6
pkgdesc="Middlewar meta-package"
arch=('any')
url=""
license=('GPL')
groups=()
depends=(
	'dhcpcd' 'networkmanager' 'net-tools' 'sudo'
	'zsh'
	'xorg-server' 'xorg-server-utils'
	'gdm'
	'awesome'
	'adwaita-icon-theme' 'dconf-editor' 'gnome-backgrounds' 
'gnome-control-center' 'gnome-desktop' 'gnome-session' 
'gnome-settings-daemon' 'gnome-shell' 'gnome-shell-extensions' 
'gnome-user-docs' 'gucharmap' 'mousetweaks' 'mutter' 'tracker' 
'xdg-user-dirs-gtk'
	'git'
)
makedepends=()
optdepends=()
provides=()
conflicts=()
replaces=()
backup=()
options=()
install=INSTALL
changelog=
source=(https://github.com/bragagia/kana-p/archive/dev-$pkgver.tar.gz)
noextract=()
md5sums=('SKIP')

package() {
	mv -T $srcdir/$pkgname-$pkgver/sources $pkgdir
}
