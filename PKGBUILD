# Maintainer: Mathias Bragagia <youremail@domain.com>
pkgname=kana-p-dev
pkgver=0.1
pkgrel=2
pkgdesc="Middlewar meta-package"
arch=('any')
url=""
license=('GPL')
groups=()
depends=(
	'xf86-input-synaptics'

	'networkmanager'
	'pulseaudio'
	'pulseaudio-alsa'
	'bluez'
	'bluez-utils'

	'net-tools'
	'sudo'

	'zsh'

	'xorg-server'
	'xorg-server-utils'

	'lightdm'
	'lightdm-gtk-greeter'

	'awesome'

	'xdg-utils'
	'xdg-user-dirs-gtk'
	'dex'

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
