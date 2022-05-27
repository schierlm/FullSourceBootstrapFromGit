#!/bin/bash -e
#
# SPDX-FileCopyrightText: 2022 Michael Schierl <schierlm@gmx.de>
#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Part 01: Finish building tcc, then build make, coreutils and bash

./get-sources.sh part02

# Create directories
mkdir -p build/chroot/opt/part02/{tcc,make,coreutils,bash}/bin
mkdir -p build/chroot/opt/part0{1,2}/tcc/lib/mes/tcc

# Remove unused files
echo "Removing unused files"
rm -R build/chroot/sources/mes-0.24/{doc,ROADMAP,build-aux,tests,mes,module,scaffold,src}
rm -R build/chroot/sources/tcc-0.9.26-janneke/{tests,win32,Makefile}
rm -R build/chroot/sources/live-bootstrap/{sysb,sysc,*.py,lib,*.md}
rm -R build/chroot/sources/live-bootstrap/sysa/{*.kaem,auto*,[dfghklpsu]*,bison*,bzip*,coreutils-6.10,make-3.82,m4*,musl*,tar*,tcc-0.9.27}
rm -R build/chroot/sources/coreutils-5.0/{configure,README,THANKS,AUTHORS,ChangeLog,*/ChangeLog,m4,po,aclocal.m4,man,tests,old}
rm -R build/chroot/sources/bash-2.05b/{doc,examples,tests,support/texi2dvi,CWRU}
rm -R build/chroot/sources/bash-2.05b/lib/termcap/grot/{termcap.info*,texinfo.tex}
rm -R build/chroot/sources/make-3.80/{*.bat,glob/*.bat,w32,*.template,*.vms,ChangeLog*}

# Fix scripts and symlinks
echo "Fixing scripts and symlinks"
cp part02/*.kaem build/chroot/sources
cp part02/coreutils/* build/chroot/sources/coreutils-5.0/src
for f in build/chroot/sources/coreutils-5.0/{src,lib}/*.{c,h} build/chroot/sources/make-3.80/*.{c,h}; do
	iconv -f iso-8859-1 -t utf-8 -o build/tmp $f && mv build/tmp $f
done
for p in modechange mbstate ls-strcmp touch-getdate touch-dereference; do
	patch -d build/chroot/sources/coreutils-5.0 -N -p0 -i ../live-bootstrap/sysa/coreutils-5.0/patches/${p}.patch
done
for p in mes-libc tinycc missing-defines locale; do
	patch -d build/chroot/sources/bash-2.05b -N -p0 -i ../live-bootstrap/sysa/bash-2.05b/patches/${p}.patch
done

find build/chroot -type f -exec chmod a-x {} +

./run-bootstrap.sh part02 "part01" './opt/part01/mescc-tools/bin/kaem --verbose --strict --file /sources/bootstrap.kaem'
