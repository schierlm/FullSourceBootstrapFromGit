#!/bin/sh

# SPDX-FileCopyrightText: 2022 Michael Schierl <schierlm@gmx.de>
#
# SPDX-License-Identifier: GPL-3.0-or-later

set -ex

export PATH=/opt/part02/coreutils/bin:${PATH}:/opt/part01/mescc-tools/bin:/opt/part02/tcc/bin:/opt/part02/make/bin:/opt/part02/bash/bin

### sed 4.0.9 ###
# configure script depends on sed
cd /sources/sed-4.0.9
catm config.h
cp /sources/live-bootstrap/sysa/sed-4.0.9/mk/main.mk Makefile
make -f Makefile LIBC=mes
cp sed/sed /opt/part02/sed/bin/sed
chmod 755 /opt/part02/sed/bin/sed

export PATH=${PATH}:/opt/part02/sed/bin
export CC=tcc

### gzip 1.2.4 ###
cd /sources/gzip-1.2.4
chmod a+x configure
./configure --prefix=/opt/part02/gzip
make
make install

### patch 2.5.9 ###
# configure script depends on expr
cd /sources/patch-2.5.9
catm config.h
catm patchlevel.h
cp pch.c pch_patched.c
sed -i 841,848d pch_patched.c
cp /sources/live-bootstrap/sysa/patch-2.5.9/mk/main.mk Makefile
make -f Makefile PREFIX=/opt/part02/patch
cp patch /opt/part02/patch/bin/patch
chmod 755 /opt/part02/patch/bin/patch

### bzip2 1.0.8 ###
cd /sources/bzip2-1.0.8
make CC=tcc AR="tcc -ar" CFLAGS="-Wall -Winline -O2 -g -I ." bzip2 bzip2recover
make PREFIX=/opt/part02/bzip2 install

### tcc 0.9.27 ###
# configure depends on uname and cut
cd /sources/tcc-0.9.27
catm config.h
libdir=/opt/part02/tcc/lib/mes
tcc -v -static \
    -o /opt/part02/tcc2/bin/tcc \
    -D TCC_TARGET_I386=1 \
    -D CONFIG_TCCDIR=\"${libdir}/tcc\" \
    -D CONFIG_TCC_CRTPREFIX=\"${libdir}\" \
    -D CONFIG_TCC_ELFINTERP=\"/mes/loader\" \
    -D CONFIG_TCC_LIBPATHS=\"${libdir}:${libdir}/tcc\" \
    -D CONFIG_TCC_SYSINCLUDEPATHS=\"/opt/part01/mes/include\" \
    -D TCC_LIBGCC=\"${libdir}/libc.a\" \
    -D CONFIG_TCC_STATIC=1 \
    -D CONFIG_USE_LIBGCC=1 \
    -D TCC_VERSION=\"0.9.27\" \
    -D ONE_SOURCE=1 \
    -D BOOTSTRAP=1 \
    tcc.c
mkdir -p /opt/part02/tcc2/lib/tcc
/opt/part02/tcc2/bin/tcc -D TCC_TARGET_I386=1 -c -o libtcc1.o lib/libtcc1.c
/opt/part02/tcc2/bin/tcc -ar rc /opt/part02/tcc2/lib/libtcc1.a libtcc1.o

export PATH=/opt/part02/tcc2/bin:${PATH}:/opt/part02/gzip/bin:/opt/part02/patch.bin:/opt/part02/bzip2/bin

### grep 2.4 ###
cd /sources/grep-2.4
cp /sources/live-bootstrap/sysa/grep-2.4/mk/main.mk Makefile
make
make install PREFIX=/opt/part02/grep

export PATH=${PATH}:/opt/part02/grep/bin

### gawk 3.0.0 ###
cd /sources/gawk-3.0.0
chmod a+x configure
CONfIG_SHELL=/opt/part02/bash/bin/bash SHELL=/opt/part02/bash/bin/bash CC=tcc CPP="tcc -E" LD="tcc" ac_cv_func_getpgrp_void=yes ac_cv_func_tzset=yes ./configure --build=i686-unknown-linux-gnu --host=i686-unknown-linux-gnu --disable-nls --prefix=/opt/part02/gawk
make gawk
install -c gawk /opt/part02/gawk/bin/gawk
ln -s gawk /opt/part02/gawk/bin/awk

export PATH=${PATH}:/opt/part02/gawk/bin

### binutils 2.14 ###
cd /sources/binutils-2.14
chmod a+x configure config.guess ltconfig */configure ld/emulparams/*.sh ld/genscripts.sh binutils/*.sh
chmod a+x install-sh mkdep move-if-change mkinstalldirs missing symlink-tree config.sub ylwrap
CONFIG_SHELL=/opt/part02/bash/bin/bash SHELL=/opt/part02/bash/bin/bash AR="tcc -ar" RANLIB=true CC="tcc -D __GLIBC_MINOR__=6" ./configure --build=i386-unknown-linux-gnu --host=i386-unknown-linux-gnu --target=i386-unknown-linux-gnu --disable-nls --disable-shared --disable-werror --with-sysroot=/ --prefix=/opt/part02/binutils
make configure-host
sed -i 's/max_cmd_len=-/max_cmd_len=32768/g' */libtool
make
make install INSTALL="/opt/part02/coreutils/bin/install -c"
## TODO manually try testsuite(s)
