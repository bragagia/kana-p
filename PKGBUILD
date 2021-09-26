# Maintainer: Mathias Bragagia <mathias.bragagia@gmail.com>
pkgname=kana-p-git
pkgver=r168.9f93944
pkgrel=1
pkgdesc="Lite Archlinux complete desktop"
arch=('any')
url="https://github.com/bragagia/kana-p"
license=('GPL')
groups=()
depends=()
makedepends=('git')
optdepends=()
provides=()
conflicts=()
replaces=()
backup=()
options=()
install=install
changelog=
noextract=()
source=('./src')
md5sums=('SKIP')
pkgver=0.1
# Depency types, by order:
# 1. Controler, sound and other driver
# 2. Network
# 3. Graphic manager
# 4. Fonts
# 5. Login manager
# 6. Widows manager and various tools
# 7. Graphic libs and themes
# 8. Terminal and shell
# 9. Work tools
depends=(
	'xf86-input-evdev'
	'xf86-input-synaptics'
	'alsa-firmware'
	'alsa-utils'
	'alsa-plugins'
	'pulseaudio'
	'pulseaudio-alsa'
	'udevil'
	'ntfs-3g'
	'gptfdisk'
	'dosfstools'
	'polkit-gnome'

	'networkmanager'
	'openssh'
	'net-tools'
	'ntp'
	'bluez'
	'bluez-utils'
	'pulseaudio-bluetooth'

	'sudo'
	'util-linux'
	'accountsservice'

	'xorg-server'
	'xorg-xmodmap'
	'xorg-xrandr'
	'light'
	'srandrd'
	'picom'

	'xorg-fonts-type1'
	'artwiz-fonts'
	'font-bh-ttf'
	'gsfonts'
	'sdl_ttf'
	'ttf-cheapskate'
	'ttf-freefont'
	'ttf-arphic-uming'
	'ttf-baekmuk'
	'ttf-dejavu'
	'ttf-bitstream-vera'
	'ttf-opensans'
	'ttf-droid'
	'ttf-inconsolata'
	'ttf-liberation'
	'otf-sauce-code-powerline-git'
	'ohsnap'
	'awesome-terminal-fonts'

	'lightdm'
	'lightdm-webkit2-greeter'
	'lightdm-webkit2-theme-bevel-git'

	'i3-gaps'
	'gnome-bluetooth'
	'blueberry'
	'gnome-keyring'
	'xsettingsd'
	'rofi'
	'polybar'
	'pavolume-git'

	'xdg-utils'
	'xdg-user-dirs'
	'dex'
	'feh'
	'most'

	'gtk2'
	'gtk3'
	'qt4-bin'
	'qt5-base'
	'numix-bevel-icon-theme'
	'arc-gtk-theme'

	'termite'
	'zsh'
	'zsh-completions'
	'ix'
	'exa'

	'google-chrome'
	'code'
	'nemo'

)

package() {
	cp -a ./. $pkgdir/
}

