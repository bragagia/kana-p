# Maintainer: Mathias Bragagia <youremail@domain.com>
pkgname=kana-p-dev
pkgver=0.1
pkgrel=1
pkgdesc="Middlewar meta-package"
arch=('any')
url=""
license=('GPL')
groups=()
depends=(
	'networkmanager'
	'net-tools'
	'sudo'

	'zsh'

	'xorg-server'
	'xorg-server-utils'

	'gdm'

	'awesome'

	'adwaita-icon-theme'
	'dconf-editor'
	'gnome-backgrounds'
	'gnome-control-center'
	'gnome-desktop'
	'gnome-session'
	'gnome-keyring'
	'gnome-settings-daemon'
	'gnome-user-docs'
	'mousetweaks' 
	'tracker'
	'xdg-user-dirs-gtk'

	'gnome-initial-setup'

	'git'

	'network-manager-applet'
)
#	'gnome-getting-started-docs'
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
