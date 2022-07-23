#!/bin/sh

# SPDX-FileCopyrightText: 2022 Michael Schierl <schierlm@gmx.de>
#
# SPDX-License-Identifier: GPL-3.0-or-later

set -ex

export PATH=${PATH}:/opt/part03/glibc/bin:/opt/part03/gcc/bin:/opt/part02/make/bin:/opt/part02/coreutils/bin:/opt/part02/bash/bin:/opt/part02/gzip/bin:/opt/part02/sed/bin:/opt/part02/patch.bin:/opt/part02/bzip2/bin:/opt/part02/grep/bin:/opt/part02/gawk/bin:/opt/part02/binutils/bin
export SHELL=/opt/part02/bash/bin/bash

### coreutils 5.0 ###

cd /opt/part02/coreutils/bin
ln -s cat uniq # no good replacement, but works for coreutil's autoconf
cd /sources/coreutils-5.0
chmod a+x configure lib/config.charset config/install-sh config/mdate-sh config/config.rpath config/config.guess
./configure --build=i686-unknown-linux-gnu --prefix=/opt/part04/coreutils --disable-dependency-tracking --disable-doc LIBS="-lc -lnss_files -lnss_dns -lresolv" ac_cv_func_gethostbyname=no ac_cv_func_rename_dest_works=yes
rm /opt/part02/coreutils/bin/uniq
make
make install

export PATH=/opt/part04/coreutils/bin:${PATH}

### sed 4.0.9 ###

cd /sources/sed-4.0.9
chmod a+x configure
./configure --prefix=/opt/part04/sed --disable-dependency-tracking
make
make install

export PATH=/opt/part04/sed/bin:${PATH}

### bash 4.4 ###

cd /sources/bash-4.4
chmod a+x configure support/config.guess support/mkconffiles support/mkdirs support/install.sh support/fixlinks support/missing
./configure --prefix=/opt/part04/bash --disable-nls --disable-net-redirections LIBS="-lc -lnss_files -lnss_dns -lresolv" ac_cv_func_dlopen=no
make
make install

export PATH=/opt/part04/bash/bin:${PATH}

cd /bin
ln -sf ../opt/part04/bash/bin/bash bash

# continue with more recent bash
exec /opt/part04/bash/bin/bash /sources/bootstrap2.sh
