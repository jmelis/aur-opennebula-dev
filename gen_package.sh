#!/bin/bash

usage() {
    echo "Usage: $0 <opennebula-repo>"
}

START_DIR=$PWD
PKG_NAME=opennebula-dev
OPENNEBULA_REPO=$1

if [ -z "$OPENNEBULA_REPO" ]; then
    usage
    exit -1
fi

################################################################################
# Clean files in build dir
################################################################################

cd $START_DIR
rm -f *.xz *.gz

################################################################################
# Tarball
################################################################################

cd $OPENNEBULA_REPO

branch=$(git symbolic-ref --short HEAD)
commit=$(git rev-parse --short HEAD)

dirty=$([[ `git diff --shortstat` != "" ]] && echo dirty)
[ -z "$dirty" ] && dirty=$(git status --porcelain 2>/dev/null | grep -q  "^A " && echo dirty)

version=$(cd $OPENNEBULA_REPO; grep "bump version" include/Nebula.h|grep -Eo '[0-9.]+')

full_version=$version-$branch-$commit
[ -n "$dirty" ] && full_version+=-dirty

full_version_pkgbuild=$version.$branch.$commit
[ -n "$dirty" ] && full_version_pkgbuild+=.dirty

TAR=$START_DIR/$PKG_NAME-${full_version}.tar.gz

git ls-files --exclude-standard -z | tar czf $TAR --null -T -

################################################################################
# Create Package
################################################################################

cd $START_DIR

VERSION=$full_version_pkgbuild TAR=$TAR makepkg --skipinteg -c

################################################################################
# Update links
################################################################################

ln -s $OPENNEBULA_REPO src





