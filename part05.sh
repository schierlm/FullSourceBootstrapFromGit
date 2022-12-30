#!/bin/bash -e
#
# SPDX-FileCopyrightText: 2022 Michael Schierl <schierlm@gmx.de>
#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Part 05: Build gcc 4.6.4

./get-sources.sh part05

# Create directories
mkdir -p build/chroot/opt/part05/gcc/{bin,lib,include} build/chroot/{bin,tmp,etc} build/chroot/sources/gcc-4.6.4/build1

# Recreate bootstrap tarballs
echo "Recreating bootstrap tarballs"
cp -R build/chroot/sources/bootstrap-tarballs/files/gcc@4.6.4/* build/chroot/sources/gcc-4.6.4
cp -R build/chroot/sources/bootstrap-tarballs/files/gmp@4.3.2/* build/chroot/sources/gmp-4.3.2
cp -R build/chroot/sources/bootstrap-tarballs/files/mpfr@2.4.2/* build/chroot/sources/mpfr-2.4.2
cp -R build/chroot/sources/bootstrap-tarballs/files/mpc@1.0.3/* build/chroot/sources/mpc-1.0.3
export FILES=../bootstrap-tarballs/files
cd build/chroot/sources/gmp-4.3.2
${FILES}/gmp@4.3.2.sh
cd ../mpfr-2.4.2
${FILES}/mpfr@2.4.2.sh
cd ../mpc-1.0.3
${FILES}/mpc@1.0.3.sh
cd ../../../..
unset FILES

# Remove unused files
echo "Removing unused files"
rm -R build/chroot/sources/bootstrap-tarballs
rm -R build/chroot/sources/gcc-4.6.4/gcc/{README*,ChangeLog*}
rm -R build/chroot/sources/gcc-4.6.4/{libiberty,intl,include}/ChangeLog
rm -R build/chroot/sources/gcc-4.6.4/MAINTAINERS
rm -R build/chroot/sources/gcc-4.6.4/contrib/regression
rm -R build/chroot/sources/gcc-4.6.4/{gcc,libstdc++-v3,libjava}/testsuite
rm -R build/chroot/sources/gcc-4.6.4/libstdc++-v3/doc/{html,xml}
rm -R build/chroot/sources/gcc-4.6.4/{libgo/go,libgfortran/m4,libgfortran/intrinsics,libgfortran/generated}
rm -R build/chroot/sources/gcc-4.6.4/boehm-gc/{cord/de_win.ICO,BCC_MAKEFILE,digimars.mak,doc/README*}
rm -R build/chroot/sources/gcc-4.6.4/libjava/{ChangeLog-*,gnu}
rm -R build/chroot/sources/gcc-4.6.4/libjava/classpath/{ChangeLog-*,m4,resource,javax,java,gnu,tools,examples,external,lib,LICENSE,THANKYOU}
rm -R build/chroot/sources/gcc-4.6.4/zlib/{projects,contrib,old}

rm -R build/chroot/sources/gmp-4.3.2/{ChangeLog,AUTHORS,doc/*.html}

# Fix files
echo "Fixing files"
cp part05/bootstrap.sh build/chroot/sources
cd build/chroot/bin
ln -s ../opt/part04/bash/bin/bash bash
ln -s bash sh
cd ../etc
ln -s ../opt/part04/etc/nsswitch.conf nsswitch.conf
cd ../../..


cd build/chroot/sources/gcc-4.6.4
patch -N -p1 -i ../guix-1.3.0/gnu/packages/patches/gcc-boot-4.6.4.patch
cd ../../../..
rm -R build/chroot/sources/guix-1.3.0

sed -i 's/#\f/#/g' build/chroot/sources/gcc-4.6.4/{{fixincludes,gcc}/Makefile.in,gcc/{fortran,objc,objcp,java,cp}/Make-lang.in}
sed -i 's/\f//g' build/chroot/sources/gcc-4.6.4/gcc/config/{fr30/fr30.{md,h},arc/arc.md,m32r/m32r.c,sparc/sparc.c}
sed -i 's/\f//g' build/chroot/sources/gcc-4.6.4/gcc/c-typeck.c
LANG=C sed -i 's/\xe2\x88\x92/-/g' build/chroot/sources/gcc-4.6.4/gcc/config/score/constraints.md
perl -CDS -pi -e 's/\x{fb01}/fi/g' build/chroot/sources/gcc-4.6.4/{gcc/fortran/intrinsic.texi,libstdc++-v3/include/{bits/forward_list.h,debug/forward_list}}
sed -i 's/\o240/ /g' build/chroot/sources/gcc-4.6.4/gcc/java/typeck.c
sed -i 's/\o33/\\e/g' build/chroot/sources/mpc-1.0.3/{ltmain.sh,test-driver,tests/Makefile.in}
sed -i 's/\f//g' build/chroot/sources/mpc-1.0.3/doc/texinfo.tex


echo 'all:' >build/chroot/sources/dummy-Makefile
echo 'install:' >>build/chroot/sources/dummy-Makefile
mkdir build/chroot/sources/gcc-4.6.4/libstdc++-v3/testsuite

for DIR in build/chroot/sources/gcc-4.6.4/{gcc,libstdc++-v3,libcpp}/po; do
	rm -R $DIR
	mkdir -p $DIR
done
cp build/chroot/sources/dummy-Makefile build/chroot/sources/gcc-4.6.4/libstdc++-v3/po/Makefile.in
cp build/chroot/sources/dummy-Makefile build/chroot/sources/gcc-4.6.4/libstdc++-v3/testsuite/Makefile.in

for f in build/chroot/sources/gcc-4.6.4/{intl/locale.alias,libiberty/strverscmp.c}; do
	iconv -f iso-8859-1 -t utf-8 -o build/tmp $f && mv build/tmp $f
done

dos2unix build/chroot/sources/gcc-4.6.4/libgcc/config/avr/t-avr
dos2unix build/chroot/sources/gcc-4.6.4/gcc/config/avr/avr-c.c
dos2unix build/chroot/sources/gcc-4.6.4/gcc/gthr-posix.c

find build/chroot/sources/gcc-4.6.4 -name '*.info' -exec truncate -s0 {} +

for f in build/chroot/sources/mpfr-2.4.2/{*.c,mpfr.texi}; do
	iconv -f iso-8859-1 -t utf-8 -o build/tmp $f && mv build/tmp $f
done

truncate -s0 build/chroot/sources/mpfr-2.4.2/mpfr.info

for f in build/chroot/sources/gmp-4.3.2/{gmp-impl.h,mpn/generic/*.c,mpz/*.c}; do
	iconv -f iso-8859-1 -t utf-8 -o build/tmp $f && mv build/tmp $f
done

truncate -s0 build/chroot/sources/gmp-4.3.2/doc/gmp.info*

truncate -s0 build/chroot/sources/mpc-1.0.3/doc/mpc.info

find build/chroot -type f -exec chmod a-x {} +

./run-bootstrap.sh part05 "part02 part03 part04" '/opt/part04/bash/bin/bash /sources/bootstrap.sh'
