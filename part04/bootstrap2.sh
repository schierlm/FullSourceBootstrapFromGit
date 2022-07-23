#!/bin/sh

# SPDX-FileCopyrightText: 2022 Michael Schierl <schierlm@gmx.de>
#
# SPDX-License-Identifier: GPL-3.0-or-later

set -ex

export PATH=/bin:/sbin:/opt/part04/coreutils/bin:/opt/part04/sed/bin:/opt/part04/bash/bin:/opt/part03/glibc/bin:/opt/part03/gcc/bin:/opt/part02/make/bin:/opt/part02/gzip/bin:/opt/part02/patch.bin:/opt/part02/bzip2/bin:/opt/part02/grep/bin:/opt/part02/gawk/bin:/opt/part02/binutils/bin
export SHELL=/opt/part04/bash/bin/bash

### diffutils 2.7 ###

cd /sources/diffutils-2.7
chmod a+x configure
./configure --prefix=/opt/part04/diffutils
make
make install

export PATH=$PATH:/opt/part04/diffutils/bin

### findutils 4.2.33 ###

cd /sources/findutils-4.2.33
chmod a+x configure mkinstalldirs
./configure --prefix=/opt/part04/findutils LIBS="-lc -lnss_files -lnss_dns -lresolv" 
make
make install

export PATH=$PATH:/opt/part04/findutils/bin

### m4 1.4.7 ###

cd /sources/m4-1.4.7
chmod a+x configure checks/get-them
./configure --prefix=/opt/part04/m4
make
make install

export PATH=$PATH:/opt/part04/m4/bin

### autoconf 2.52 ###

cd /sources/autoconf-2.52
chmod a+x configure
./configure --prefix=/opt/part04/autoconf
make
make install

### tar 1.22 ###

cd /sources/tar-1.22
chmod a+x configure
./configure --prefix=/opt/part04/tar LIBS="-lc -lnss_files -lnss_dns -lresolv" 
make
make install

export PATH=/opt/part04/tar/bin:$PATH

### gawk 3.1.8 ###

cd /sources/gawk-3.1.8
chmod a+x configure install-sh
./configure --prefix=/opt/part04/gawk LDFLAGS="-lc -lnss_files -lnss_dns -lresolv" LIBS="-lc -lnss_files -lnss_dns -lresolv" 
make
make install

export PATH=/opt/part04/gawk/bin:$PATH

### make 3.82 ###

cd /sources/make-3.82
chmod a+x configure
./configure --prefix=/opt/part04/make LIBS="-lc -lnss_files -lnss_dns -lresolv"
make
make install

export PATH=/opt/part04/make/bin:$PATH

### patch 2.5.9 ###

cd /sources/patch-2.5.9
chmod a+x configure
./configure --prefix=/opt/part04/patch
make
make install

export PATH=/opt/part04/patch/bin:$PATH

### grep 2.4 ###

cd /sources/grep-2.4
chmod a+x configure config.guess missing
./configure --prefix=/opt/part04/grep --host=i686-unknown-linux-gnu --disable-nls LIBS="-lc -lnss_files -lnss_dns -lresolv"
make
make install

export PATH=/opt/part04/grep/bin:$PATH
