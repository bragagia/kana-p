# Maintainer: Mathias Bragagia <youremail@domain.com>
pkgname=kana-p-dev
pkgver=0.0.3
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
	'slim'
	'awesome'
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
source=(https://github.com/bragagia/kana-p/archive/dev-0.0.3.tar.gz)
noextract=()
md5sums=('SKIP')

package() {
	mv -T $srcdir/$pkgname/sources $pkgdir
	cd $pkgdir
	cp -r etc/kana-p/home/ etc/skel
}
