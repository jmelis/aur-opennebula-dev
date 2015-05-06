pkgname=opennebula
pkgver=$VERSION
pkgrel=1
pkgdesc="Virtual management infrastructure as a service (IaaS) toolkit for cloud computing (NOTE: Read the PKGBUILD!)"
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
