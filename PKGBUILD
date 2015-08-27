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
