#!/bin/bash -e
#
# SPDX-FileCopyrightText: 2022 Michael Schierl <schierlm@gmx.de>
#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Part 02: Finish building tcc, then build make, coreutils, bash, etc.; up to binutils

./get-sources.sh part02

# Create directories
mkdir -p build/chroot/opt/part02/{tcc,make,coreutils,bash,sed,gzip,tcc2,gawk,grep,patch}/bin
mkdir -p build/chroot/opt/part0{1,2}/tcc/lib/mes/tcc

# Recreate bootstrap tarballs
echo "Recreating bootstrap tarballs"
cp -R build/chroot/sources/bootstrap-tarballs/files/gzip@1.2.4/* build/chroot/sources/gzip-1.2.4/
cp -R build/chroot/sources/bootstrap-tarballs/files/sed@4.0.9/* build/chroot/sources/sed-4.0.9/
cp -R build/chroot/sources/bootstrap-tarballs/files/binutils@2.14/* build/chroot/sources/binutils-2.14/
cp -R build/chroot/sources/bootstrap-tarballs/files/grep@2.4/* build/chroot/sources/grep-2.4/
cp build/chroot/sources/bootstrap-tarballs/files/coreutils@5.0/src/*.{c,h} build/chroot/sources/coreutils-5.0/src
export FILES=../bootstrap-tarballs/files
cd build/chroot/sources/gzip-1.2.4
${FILES}/gzip@1.2.4.sh
cd ../sed-4.0.9
${FILES}/sed@4.0.9.sh
cd ../bzip2-1.0.8
${FILES}/bzip2@1.0.8.sh
cd ../tcc-0.9.27
${FILES}/tcc@0.9.27.sh
cd ../grep-2.4
${FILES}/grep@2.4.sh
cd ../binutils-2.14
${FILES}/binutils@2.14.sh
cd ../../../..
unset FILES

# Remove unused files
echo "Removing unused files"
rm -R build/chroot/sources/bootstrap-tarballs
rm -R build/chroot/sources/mes-0.24/{doc,ROADMAP,build-aux,tests,mes,module,scaffold,src}
rm -R build/chroot/sources/tcc-0.9.26-janneke/{tests,win32,Makefile}
rm -R build/chroot/sources/live-bootstrap/{sysb,sysc,*.py,lib,*.md}
rm -R build/chroot/sources/live-bootstrap/sysa/{*.kaem,auto*,[dfhklu]*,bison*,coreutils-6.10,gcc*,gawk*,gzip*,make-3.82,m4*,musl*,perl*,tar*,stage0-posix}
rm -R build/chroot/sources/coreutils-5.0/{configure,README,THANKS,AUTHORS,ChangeLog,*/ChangeLog,m4,po,aclocal.m4,man,tests,old}
rm -R build/chroot/sources/bash-2.05b/{doc,examples,tests,support/texi2dvi,CWRU}
rm -R build/chroot/sources/bash-2.05b/lib/termcap/grot/{termcap.info*,texinfo.tex}
rm -R build/chroot/sources/make-3.80/{*.bat,glob/*.bat,w32,*.template,*.vms,ChangeLog*}
rm -R build/chroot/sources/gawk-3.0.0/{pc/include,pc/*.def,pc/popen.h,doc/texinfo.tex}
rm -R build/chroot/sources/tcc-0.9.27/{tests,win32}
rm -R build/chroot/sources/gzip-1.2.4/texinfo.tex
rm -R build/chroot/sources/bzip2-1.0.8/{sample*,bzip2.1.preformatted,*.dsp,dlltest.c,libbz2.def,makefile.msc}
rm -R build/chroot/sources/patch-2.5.9/pc
rm -R build/chroot/sources/sed-4.0.9/{po,testsuite,intl/locale.alias,ChangeLog,config/texi2dvi}
rm -R build/chroot/sources/grep-2.4/{po,tests,djgpp,doc/grep.info,intl/ChangeLog,PATCHES.*}
rm -R build/chroot/sources/binutils-2.14/{ld,libiberty,intl,include,gas,bfd,binutils}/ChangeLog*
rm -R build/chroot/sources/binutils-2.14/{ld,gas,binutils}/testsuite
rm -R build/chroot/sources/binutils-2.14/etc/*.jin
rm -R build/chroot/sources/binutils-2.14/bfd/configure.com
rm -R build/chroot/sources/binutils-2.14/binutils/MAINTAINERS

# Fix files
echo "Fixing files"
cp part02/*.{kaem,sh} build/chroot/sources
sed -i 's/\f//g' build/chroot/sources/binutils-2.14/gprof/bsd_callg_bl.c

patch -d build/chroot/sources/gzip-1.2.4 -N -p1 -i ../../../../part02/gzip-1.2.4.patch
patch -d build/chroot/sources/gawk-3.0.0 -N -p1 -i ../../../../part02/gawk-3.0.0.patch
cp build/chroot/sources/live-bootstrap/sysa/coreutils-5.0/mk/main.mk build/chroot/sources/coreutils-5.0/Makefile
patch -d build/chroot/sources/coreutils-5.0 -N -p1 -i ../../../../part02/coreutils-5.0-dirname-expr-sort.patch
patch -d build/chroot/sources/sed-4.0.9 -N -p1 -i ../../../../part02/sed-4.0.9-fflush-null.patch

for f in build/chroot/sources/gzip-1.2.4/gzip.info build/chroot/sources/sed-4.0.9/doc/*.info* build/chroot/sources/binutils-2.14/{etc,gprof,ld,bfd/doc,gas/doc,binutils/doc}/*.info*; do
	rm -R $f
	touch $f
done

for DIR in build/chroot/sources/binutils-2.14/{gas,ld,opcodes,gprof,bfd,binutils}/po; do
	rm -R $DIR
	mkdir -p $DIR
	echo 'all:' >$DIR/Make-in
	echo 'install:' >>$DIR/Make-in
	echo 'install-info:' >>$DIR/Make-in
done

for f in build/chroot/sources/coreutils-5.0/{src,lib}/*.{c,h} build/chroot/sources/make-3.80/*.{c,h} build/chroot/sources/sed-4.0.9/lib/*.c; do
	iconv -f iso-8859-1 -t utf-8 -o build/tmp $f && mv build/tmp $f
done
for f in build/chroot/sources/binutils-2.14/{gas/config,bfd,bfd/hosts}/*.{c,h}; do
	[ -s "${f}" ] || continue
	iconv -f iso-8859-1 -t utf-8 -o build/tmp $f && mv build/tmp $f
done
for p in modechange mbstate ls-strcmp touch-getdate touch-dereference; do
	patch -d build/chroot/sources/coreutils-5.0 -N -p0 -i ../live-bootstrap/sysa/coreutils-5.0/patches/${p}.patch
done
for p in mes-libc tinycc missing-defines locale; do
	patch -d build/chroot/sources/bash-2.05b -N -p0 -i ../live-bootstrap/sysa/bash-2.05b/patches/${p}.patch
done

patch -d build/chroot/sources/bzip2-1.0.8 -N -p0 -i ../live-bootstrap/sysa/bzip2-1.0.8/patches/mes-libc.patch
patch -d build/chroot/sources/tcc-0.9.27 -N -p0 -i ../live-bootstrap/sysa/tcc-0.9.27/patches/static-link.patch

find build/chroot -type f -exec chmod a-x {} +

./run-bootstrap.sh part02 "part01" './opt/part01/mescc-tools/bin/kaem --verbose --strict --file /sources/bootstrap.kaem'
