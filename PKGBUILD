pkgname=opennebula
pkgver=$VERSION
pkgrel=1
pkgdesc="Developer Package of OpenNebula"
arch=('x86_64')
url='http://docs.opennebula.org/stable'
license=('Apache')
source=("$TAR")

build() {
    cd "${srcdir}"
    scons -j5
}

package() {
    cd "${srcdir}"
    DESTDIR="${pkgdir}" ./install.sh -l -u $(id -u -n) -g $(id -g -n)
}
