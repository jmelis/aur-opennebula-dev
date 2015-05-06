#!/bin/bash

START_DIR=$PWD

################################################################################
# Clean files in build dir
################################################################################

cd $START_DIR
rm -f *.xz *.gz

################################################################################
# Tarball
################################################################################

cd $1

branch=$(git symbolic-ref --short HEAD)
commit=$(git rev-parse --short HEAD)

dirty=$([[ `git diff --shortstat` != "" ]] && echo dirty)
[ -z "$dirty" ] && dirty=$(git status --porcelain 2>/dev/null | grep -q  "^A " && echo dirty)

version=$(cd $1; grep "bump version" include/Nebula.h|grep -Eo '[0-9.]+')

full_version=$version-$branch-$commit
[ -n "$dirty" ] && full_version+=-dirty

full_version_pkgbuild=$version.$branch.$commit
[ -n "$dirty" ] && full_version_pkgbuild+=.dirty

TAR=$START_DIR/opennebula-${full_version}.tar.gz

git ls-files --exclude-standard -z | tar czf $TAR --null -T -

################################################################################
# Create Package
################################################################################

cd $START_DIR

VERSION=$full_version_pkgbuild TAR=$TAR makepkg --skipinteg
