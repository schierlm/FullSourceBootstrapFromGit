#!/bin/bash -e
#
# SPDX-FileCopyrightText: 2022 Michael Schierl <schierlm@gmx.de>
#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Part 01: Build stage0-posix, mescc-tools, mescc-tools-extra, M2-Planet, mes(cc), and initial tcc.

./get-sources.sh part01

# Create directories
mkdir -p build/opt/part00 build/chroot/bootstrap-seeds/POSIX build/chroot/opt/part01/{mescc-tools,mes,tcc}/bin
mkdir -p build/chroot/opt/part01/mes/{lib,include}

# Build part00-output.tar.xz here...
echo "Building part00-output.tar.xz"
sed 's/[;#].*$//g' build/chroot/x86/hex0_x86.hex0 | xxd -r -p > build/opt/part00/hex0-seed
sed 's/[;#].*$//g' build/chroot/x86/kaem-minimal.hex0 | xxd -r -p > build/opt/part00/kaem-optional-seed
chmod a+x build/opt/part00/*-seed
tar cfJ cache/part00-output.tar.xz -C build --mode="go-rwx,u+rw,a-s" --sort=name --mtime='2000-01-01' --owner=0 --group=0 --numeric-owner opt

# Remove unused files
echo "Removing unused files"
rm -R build/opt build/chroot/{AArch64,AMD64,armv7l,High\ Level\ Prototypes,kaem.[ar]*,Legacy_pieces,riscv32,riscv64,*.answers,after.kaem}
rm -R build/chroot/x86/{Development,NASM,bin}
rm -R build/chroot/{mescc-tools{,/Kaem},M2-Planet,M2-Mesoplanet}/test
rm -R build/chroot/live-bootstrap/{sysb,sysc,*.py,lib,*.md}
rm -R build/chroot/live-bootstrap/sysa/{*.kaem,auto*,[bcdfghklpsu]*,m4*,make*,musl*,tar*,tcc-0.9.27}
rm -R build/chroot/{mescc-tools,mescc-tools-extra,M2-Mesoplanet}/makefile
rm -R build/chroot/mes-0.24/{doc,ROADMAP,build-aux,tests}
rm -R build/chroot/mes-0.24/mes/module/mes/psyntax.*
rm -R build/chroot/nyacc-1.00.2/{doc,examples,test-suite}
rm -R build/chroot/tcc-0.9.26-janneke/{tests,win32,Makefile}

# Fix scripts and symlinks
echo "Fixing scripts and symlinks"
cp part01/{after.kaem,x86.answers} build/chroot
cp build/chroot/live-bootstrap/sysa/mes-0.24/files/mescc.scm build/chroot/opt/part01/mes/bin/mescc.scm
ln -s ../../../live-bootstrap/sysa/mes-0.24/files/config.h build/chroot/mes-0.24/include/mes/config.h
ln -s ../../opt/part00 build/chroot/bootstrap-seeds/POSIX/x86
ln -s ../opt/part01/mescc-tools/bin build/chroot/x86/bin
sed -i 's/\f//g' build/chroot/mes-0.24/module/mescc/compile.scm build/chroot/mes-0.24/scaffold/*-mes.c

for libdir in M2-Planet M2-Mesoplanet mescc-tools mescc-tools-extra; do
	rm -R build/chroot/${libdir}/M2libc
	ln -sf ../M2libc build/chroot/${libdir}/M2libc
done

find build/chroot -type f -exec chmod a-x {} +

./run-bootstrap.sh part01 "part00" './opt/part00/kaem-optional-seed'
