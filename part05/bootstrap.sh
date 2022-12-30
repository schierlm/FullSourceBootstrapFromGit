#!/bin/sh

# SPDX-FileCopyrightText: 2022 Michael Schierl <schierlm@gmx.de>
#
# SPDX-License-Identifier: GPL-3.0-or-later

set -ex

export PATH=/bin:/sbin:/opt/part04/coreutils/bin:/opt/part04/sed/bin:/opt/part04/bash/bin:/opt/part04/patch/bin:/opt/part04/make/bin:/opt/part04/tar/bin:/opt/part04/findutils/bin:/opt/part04/diffutils/bin:/opt/part04/m4/bin:/opt/part03/glibc/bin:/opt/part04/grep/bin:/opt/part04/gawk/bin:/opt/part03/gcc/bin:/opt/part02/gzip/bin:/opt/part02/bzip2/bin:/opt/part02/binutils/bin
export SHELL=/opt/part04/bash/bin/bash

### gcc 4.6.4 ###

cd /sources/gcc-4.6.4

chmod a+x install-sh symlink-tree ylwrap config.sub missing compile mkdep libtool-ldflags configure move-if-change config.rpath mkinstalldirs \
  depcomp config.guess \
  */configure \
  fixincludes/fixinc.in fixincludes/mkfixinc.sh fixincludes/genfixes \
  contrib/compare-debug  contrib/patch_tester.sh contrib/warn_summary contrib/gennews contrib/compareSumTests3 contrib/test_installed \
  contrib/filter_params.pl contrib/gcc_update contrib/test_summary contrib/uninclude contrib/check_GNU_style.sh contrib/analyze_brprob \
  contrib/download_prerequisites contrib/gcc_build contrib/test_recheck contrib/texi2pod.pl contrib/filter_gcc_for_doxygen \
  contrib/check_warning_flags.sh contrib/filter_knr2ansi.pl contrib/dg-cmp-results.sh contrib/dg-extract-results.sh contrib/compare_tests \
  contrib/index-prop contrib/prepare_patch.sh contrib/reghunt/bin/reg-newmid contrib/reghunt/bin/gcc-svn-update-fix \
  contrib/reghunt/bin/gcc-test-compiler-hangs contrib/reghunt/bin/gcc-test-rejects-valid contrib/reghunt/bin/gcc-test-segfault-on-valid-code \
  contrib/reghunt/bin/reg-hunt contrib/reghunt/bin/gcc-test-ice-on-invalid-code contrib/reghunt/bin/gcc-build-simple \
  contrib/reghunt/bin/gcc-test-ice-on-valid-code contrib/reghunt/bin/gcc-svn-patchlist contrib/reghunt/bin/gcc-test-wrong-code \
  contrib/reghunt/bin/gcc-svn-update contrib/reghunt/bin/gcc-test-bogus-warning contrib/reghunt/bin/gcc-build-full contrib/reghunt/bin/gcc-svn-checkfail \
  contrib/reghunt/bin/gcc-test-accepts-invalid contrib/reghunt/bin/gcc-svn-ids contrib/reghunt/bin/gcc-test-missing-warning \
  contrib/reghunt/bin/gcc-svn-report contrib/reghunt/bin/gcc-svn-recordfail contrib/reghunt/bin/gcc-cleanup contrib/reghunt/bin/reg-test \
  contrib/reghunt/date_based/reg_periodic contrib/reghunt/date_based/reg_search contrib/reghunt/date_based/reg_test_template \
  contrib/reghunt/examples/reg-watch contrib/reghunt/examples/testall contrib/reghunt/examples/30643.test contrib/reghunt/examples/reg-watch.awk \
  contrib/reghunt/examples/29106.test contrib/download_ecj \
  gcc/ada/g-byorma.adb gcc/ada/g-spchge.ads gcc/ada/a-zchara.ads gcc/ada/s-string.ads gcc/ada/a-suenst.ads gcc/ada/sem_aux.adb gcc/ada/s-utf_32.adb \
  gcc/ada/aspects.adb gcc/ada/a-suenco.adb gcc/ada/a-assert.adb gcc/ada/aspects.ads gcc/ada/a-coteio.ads gcc/ada/g-wispch.ads gcc/ada/a-tirsfi.adb \
  gcc/ada/s-regpat.adb gcc/ada/a-chacon.adb gcc/ada/a-zrstfi.ads gcc/ada/s-os_lib.adb gcc/ada/s-tasloc.adb gcc/ada/a-exetim-mingw.adb \
  gcc/ada/a-fzteio.ads gcc/ada/s-os_lib.ads gcc/ada/g-decstr.ads gcc/ada/s-utf_32.ads gcc/ada/sem_aux.ads gcc/ada/s-tasloc.ads gcc/ada/g-wispch.adb \
  gcc/ada/namet-sp.adb gcc/ada/a-scteio.ads gcc/ada/s-regexp.adb gcc/ada/a-suezst.adb gcc/ada/a-zchhan.adb gcc/ada/a-suewst.adb gcc/ada/a-chacon.ads \
  gcc/ada/a-envvar.ads gcc/ada/s-except.adb gcc/ada/a-suezst.ads gcc/ada/a-wichha.ads gcc/ada/s-regexp.ads gcc/ada/s-string.adb gcc/ada/a-tirsfi.ads \
  gcc/ada/a-llctio.ads gcc/ada/a-exetim-mingw.ads gcc/ada/a-wichha.adb gcc/ada/g-encstr.adb gcc/ada/g-spchge.adb gcc/ada/a-zrstfi.adb \
  gcc/ada/a-lcteio.ads gcc/ada/g-decstr.adb gcc/ada/g-zspche.ads gcc/ada/a-suenco.ads gcc/ada/a-assert.ads gcc/ada/a-envvar.adb gcc/ada/a-suenst.adb \
  gcc/ada/a-zchuni.adb gcc/ada/g-encstr.ads gcc/ada/a-zchuni.ads gcc/ada/g-u3spch.adb gcc/ada/s-regpat.ads gcc/ada/g-byorma.ads gcc/ada/s-wchcon.adb \
  gcc/ada/a-izteio.ads gcc/ada/g-u3spch.ads gcc/ada/namet-sp.ads gcc/ada/a-suewst.ads gcc/ada/a-zchhan.ads gcc/ada/g-zspche.adb \
  gcc/config/arm/gentune.sh gcc/config/avr/predicates.md gcc/config/avr/avr-devices.c gcc/config/avr/driver-avr.c gcc/doc/install.texi2html \
  boehm-gc/callprocs boehm-gc/depcomp \
  libstdc++-v3/scripts/testsuite_flags.in libstdc++-v3/scripts/extract_symvers.in libstdc++-v3/scripts/create_testsuite_files \
  libstdc++-v3/scripts/make_graphs.py libstdc++-v3/scripts/make_graph.py libstdc++-v3/scripts/check_performance libstdc++-v3/scripts/check_compile \
  libgo/testsuite/gotest libgo/mksysinfo.sh \
  libffi/msvcc.sh \
  libgfortran/mk-srk-inc.sh libgfortran/mk-kinds-h.sh libgfortran/mk-sik-inc.sh \
  libjava/scripts/unicode-to-chartables.pl libjava/scripts/unicode-muncher.pl libjava/scripts/unicode-blocks.pl libjava/scripts/makemake.tcl \
  libjava/scripts/unicode-decomp.pl libjava/classpath/org/omg/CORBA/BAD_OPERATION.java libjava/classpath/org/omg/CORBA/WStringSeqHolder.java \
  libjava/classpath/org/omg/CORBA/StringSeqHolder.java libjava/classpath/install-sh libjava/classpath/scripts/generate-locale-list.sh \
  libjava/classpath/scripts/import-cacerts.sh libjava/classpath/config.sub libjava/classpath/missing \
  libjava/classpath/compile libjava/classpath/ltconfig libjava/classpath/config.rpath libjava/classpath/autogen.sh \
  libjava/classpath/mkinstalldirs libjava/classpath/depcomp libjava/classpath/doc/texi2pod.pl libjava/libltdl/install-sh \
  libjava/libltdl/config.sub libjava/libltdl/missing \
  maintainer-scripts/update_web_docs_svn maintainer-scripts/maintainer-addresses maintainer-scripts/update_version_svn \
  maintainer-scripts/update_web_docs_libstdcxx_svn maintainer-scripts/gcc_release

ln -s ../gmp-4.3.2 gmp
ln -s ../mpfr-2.4.2 mpfr
ln -s ../mpc-1.0.3 mpc

cd /sources/gcc-4.6.4/build1

export CONFIG_SHELL=/opt/part02/bash/bin/bash
export C_INCLUDE_PATH=/opt/part03/gcc/lib/gcc-lib/i686-unknown-linux-gnu/2.95.3/include:/opt/part03/api-headers/include:/opt/part03/glibc/include:/sources/gcc-4.6.4/mpfr/src
export CPLUS_INCLUDE_PATH=${C_INCLUDE_PATH}
export LIBRARY_PATH=/opt/part03/glibc/lib:/opt/part03/gcc/lib
echo "ac_cv_c_float_format='IEEE (little-endian)'" >config.cache

../configure --disable-shared --disable-werror --build=i686-unknown-linux-gnu --host=i686-unknown-linux-gnu --prefix=/opt/part05/gcc \
  --with-native-system-header-dir=/opt/part03/glibc/include --with-build-sysroot=/opt/part03/glibc/include \
  --disable-bootstrap --disable-decimal-float --disable-libatomic --disable-libcilkrts --disable-libgomp --disable-libitm --disable-libmudflap \
  --disable-libquadmath --disable-libsanitizer --disable-libssp --disable-libvtv --disable-lto --disable-lto-plugin --disable-multilib \
  --disable-plugin --disable-threads --enable-languages=c,c++ --enable-static --enable-threads=single --disable-libstdcxx-pch --disable-build-with-cxx

make LDFLAGS="-B/opt/part03/glibc/lib -Wl,-dynamic-linker -Wl,/opt/part03/glibc" LDFLAGS_FOR_TARGET="-B/opt/part03/glibc/lib -Wl,-dynamic-linker -Wl,/opt/part03/glibc"
make install
export PATH=/opt/part05/gcc/bin:${PATH}

cd /opt/part05/gcc/lib
ln -s ../../../part03/glibc/lib/* .
cd ../include
ln -s ../../../part03/glibc/include/* .
rm scsi
ln -s ../../../part03/api-headers/include/* .
rm scsi
mkdir scsi
cd scsi
ln -s ../../../../part03/glibc/include/scsi/* .
ln -s ../../../../part03/glibc/api-headers/scsi/* .
