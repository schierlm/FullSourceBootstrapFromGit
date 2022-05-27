#!/bin/bash -e
#
# SPDX-FileCopyrightText: 2022 Michael Schierl <schierlm@gmx.de>
#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Run a single part: Check input files and package input tarball, 
# extract previous stage tarballs, run the actual chroot bootstrap,
# and package the output tarball

PART="$1"
DEPENDS="$2"
CHROOT_CMD="$3"

umask 022
echo "Checking files..."
./checkfiles.pl build/chroot

echo "Packaging input tarball..."
tar cfJ build/${PART}-input.tar.xz -C build/chroot --sort=name --mtime='2000-01-01' --owner=0 --group=0 --numeric-owner .

echo "Extracting dependencies..."
for DEPEND in ${DEPENDS}; do
	tar xfJ cache/${DEPEND}-output.tar.xz -C build/chroot
done

echo "Providing device nodes..."
mkdir -p build/chroot/{dev,proc,sys}
cp -a /dev/{null,zero,random,urandom,tty} build/chroot/dev

echo "Running the part..."
mount --bind /proc build/chroot/proc
mount --bind /sys build/chroot/sys
trap "umount build/chroot/proc; umount build/chroot/sys" EXIT
unshare --net env - PATH=/bin:/sbin $(which chroot) build/chroot ${CHROOT_CMD}

echo "Packaging output tarball..."
rm -rf build/opt
mkdir -p build/opt/${PART}
cp -R build/chroot/opt/${PART}/. build/opt/${PART}
tar cfJ cache/${PART}-output.tar.xz -C build --mode="go-rwx,u+rw,a-s" --sort=name --mtime='2000-01-01' --owner=0 --group=0 --numeric-owner opt

echo "Part done!"
