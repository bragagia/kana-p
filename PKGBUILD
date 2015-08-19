# Maintainer: Mathias Bragagia <youremail@domain.com>
pkgname=kana-p-dev
pkgver=1
pkgrel=0.0.1
pkgdesc="Middlewar meta-package"
arch=('any')
url=""
license=('GPL')
groups=()
depends=(
	'dhcpcd' 
	'xorg-server' 'xorg-server-utils'
	'slim'
	'awesome'
)
makedepends=()
optdepends=()
provides=()
conflicts=()
replaces=()
backup=()
options=()
install=.install
changelog=
source=(git://github.com/bragagia/kana-p.git#dev)
noextract=()
md5sums=('SKIP')

package() {
	cp -r trunk/sources $pkgdir
	echo $pkgdir
	rm -r trunk
}
