#!/usr/bin/env bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./build_aux
set -exuo pipefail
# GCC 15 defaults to C23, where `int (*)()` means no arguments; gnucobol 3.2 assumes the old meaning
export CFLAGS="$CFLAGS -std=gnu17"
./configure \
    --prefix=$PREFIX \
    --disable-silent-rules \
    --with-libiconv-prefix=$PREFIX \
    --with-libintl-prefix=$PREFIX \
    --with-json=json-c \
    --with-xml2=libxml2 \
    --with-curses=ncursesw \
    --with-db=db

make install
