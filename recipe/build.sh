#!/usr/bin/env bash

set -exuo pipefail

if [[ "$target_platform" == "win-64" ]];
then
    ./configure \
        --prefix=$PREFIX \
        --disable-silent-rules \
        --with-libiconv-prefix=$PREFIX \
        --with-libintl-prefix=$PREFIX \
        --with-json=json-c \
        --with-xml2=libxml2 \
        --with-curses=pdcurses \
        --with-math=mpir \
        --with-db=db || (cat config.log; exit 1)
    patch_libtool
else
    ./configure \
        --prefix=$PREFIX \
        --disable-silent-rules \
        --with-libiconv-prefix=$PREFIX \
        --with-libintl-prefix=$PREFIX \
        --with-json=json-c \
        --with-xml2=libxml2 \
        --with-curses=ncursesw \
        --with-math=gmp \
        --with-db=db
fi

make -j${CPU_COUNT}
make install
