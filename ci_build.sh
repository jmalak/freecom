#!/bin/sh

set -e

if [ ! -z "${TRAVIS_BUILD_DIR}" ] ; then
  CI_BUILD_DIR=${TRAVIS_BUILD_DIR}
else
  CI_BUILD_DIR=$(pwd)
fi
echo CI_BUILD_DIR is \"${CI_BUILD_DIR}\"

# Open Watcom
OWTAR=ow-snapshot.tar.xz
if [ ! -d _watcom ] ; then
  mkdir -p _downloads
  mkdir _watcom
  if [ ! -f _downloads/$OWTAR ] ; then
    (cd _downloads && wget --no-verbose https://github.com/open-watcom/open-watcom-v2/releases/download/Last-CI-build/$OWTAR)
  fi
  (cd _watcom && tar -xf ../_downloads/$OWTAR)
fi
export PATH=$CI_BUILD_DIR/bin:$PATH:$CI_BUILD_DIR/_watcom/binl64
export WATCOM=$CI_BUILD_DIR/_watcom
export INCLUDE=$INCLUDE:$CI_BUILD_DIR/_watcom/lh

# Output directory
rm -rf _output
mkdir _output

# Which ones to build
LANGUAGES="english dutch finnish french german italian polish pt pt_br russian serbian slovene spanish swedish turkish ukr yu437"

# GCC
for lng in ${LANGUAGES} ; do
  # Do full clean for rebuild of each language
  echo "Do full clean"
  git clean -x -d -f -e _output -e _watcom -e _download >/dev/null 2>&1
  export LNG=${lng}
  ./build.sh gcc
  TGT="_output/gcc/${LNG}"
  mkdir -p ${TGT}
  mv -i command.com ${TGT}/.
done

# Watcom
for lng in ${LANGUAGES} ; do
  # Do full clean for rebuild of each language
  echo "Do full clean"
  git clean -x -d -f -e _output -e _watcom -e _download >/dev/null 2>&1
  export LNG=${lng}
  ./build.sh wc
  TGT="_output/wc/${LNG}"
  mkdir -p ${TGT}
  mv -i command.com ${TGT}/.
done

echo done
