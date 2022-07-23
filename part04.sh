#!/bin/bash -e
#
# SPDX-FileCopyrightText: 2022 Michael Schierl <schierlm@gmx.de>
#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Part 04: Rebuild coreutils, bash, etc. Build diffutils, findutils, and autotools.

./get-sources.sh part04

# Create directories
mkdir -p build/chroot/opt/part04/{coreutils,bash,sed,gawk,grep,patch}/bin build/chroot/opt/part04/etc build/chroot/{bin,tmp,etc}

# Recreate bootstrap tarballs
echo "Recreating bootstrap tarballs"
cp -R build/chroot/sources/bootstrap-tarballs/files/coreutils@5.0/* build/chroot/sources/coreutils-5.0/
cp -R build/chroot/sources/bootstrap-tarballs/files/sed@4.0.9/* build/chroot/sources/sed-4.0.9/
cp -R build/chroot/sources/bootstrap-tarballs/files/diffutils@2.7/* build/chroot/sources/diffutils-2.7/
cp -R build/chroot/sources/bootstrap-tarballs/files/findutils@4.2.33/* build/chroot/sources/findutils-4.2.33/
cp -R build/chroot/sources/bootstrap-tarballs/files/m4@1.4.7/* build/chroot/sources/m4-1.4.7/
cp -R build/chroot/sources/bootstrap-tarballs/files/autoconf@2.52/* build/chroot/sources/autoconf-2.52/
cp -R build/chroot/sources/bootstrap-tarballs/files/tar@1.22/* build/chroot/sources/tar-1.22/
cp -R build/chroot/sources/bootstrap-tarballs/files/make@3.82/* build/chroot/sources/make-3.82/
cp -R build/chroot/sources/bootstrap-tarballs/files/grep@2.4/* build/chroot/sources/grep-2.4/
export FILES=../bootstrap-tarballs/files
cd build/chroot/sources/coreutils-5.0
${FILES}/coreutils@5.0.sh
cd ../sed-4.0.9; ${FILES}/sed@4.0.9.sh
cd ../diffutils-2.7; ${FILES}/diffutils@2.7.sh
cd ../findutils-4.2.33; ${FILES}/findutils@4.2.33.sh
cd ../m4-1.4.7; ${FILES}/m4@1.4.7.sh
cd ../autoconf-2.52; ${FILES}/autoconf@2.52.sh
cd ../tar-1.22; ${FILES}/tar@1.22.sh
cd ../make-3.82; ${FILES}/make@3.82.sh
cd ../grep-2.4; ${FILES}/grep@2.4.sh
cd ../../../..
unset FILES

# Remove unused files
echo "Removing unused files"
rm -R build/chroot/sources/bootstrap-tarballs
rm -R build/chroot/sources/coreutils-5.0/{README,THANKS,AUTHORS,ChangeLog,*/ChangeLog,po,man,tests,old,doc/Makefile.in}
rm -R build/chroot/sources/bash-4.4/{doc,examples,tests,support/texi2dvi,ChangeLog,CWRU,po/*.po,po/*.gmo,po/*.sed}
rm -R build/chroot/sources/gawk-3.1.8/{pc/include,pc/*.def,pc/popen.h,doc/{texinfo.tex,awkcard.in,statist.*,*flashlight*,gawk{,inet}.info},po/*,test/*,unsupported,pc,extension}
rm -R build/chroot/sources/patch-2.5.9/pc
rm -R build/chroot/sources/sed-4.0.9/{po,testsuite,intl/locale.alias,ChangeLog,config/texi2dvi}
rm -R build/chroot/sources/grep-2.4/{po/*,tests/*,djgpp/*,doc/grep.info,intl/ChangeLog,PATCHES.*}
rm -R build/chroot/sources/m4-1.4.7/{doc/m4.texinfo,doc/m4.info,TODO,checks/0*,checks/1*}
rm -R build/chroot/sources/findutils-4.2.33/{doc/find.info,m4/order-*.bin,po/*,find/testsuite/find.*,xargs/testsuite/{xargs.*,inputs}}
rm -R build/chroot/sources/tar-1.22/{README,PORTS,TODO,NEWS,doc/tar.info*,po/*,tests/*}
rm -R build/chroot/sources/make-3.82/{doc/make.info*,*.bat,glob/*.bat,w32/*,*.vms,*-vms,*.sln,*.vcproj,po/*}
rm -R build/chroot/sources/diffutils-2.7/{diff.info*,texinfo.tex}
rm -R build/chroot/sources/autoconf-2.52/{doc/{autoconf,standards}.info,ChangeLog*,THANKS}

# Fix files
echo "Fixing files"
cp part04/bootstrap{,2}.sh build/chroot/sources
cp part04/nsswitch.conf build/chroot/opt/part04/etc
cd build/chroot/bin
ln -s ../opt/part02/bash/bin/bash bash
ln -s bash sh
cd ../etc
ln -s ../opt/part04/etc/* .
cd ../../..

for f in build/chroot/sources/coreutils-5.0/doc/coreutils.info build/chroot/sources/sed-4.0.9/doc/*.info*; do
	rm -R $f
	touch $f
done
touch build/chroot/sources/m4-1.4.7/doc/m4.{tex,}info
touch build/chroot/sources/findutils-4.2.33/doc/find.info
touch build/chroot/sources/tar-1.22/doc/tar.info
touch build/chroot/sources/make-3.82/doc/make.info
touch build/chroot/sources/make-3.82/w32/Makefile.in
touch build/chroot/sources/diffutils-2.7/diff.info
touch build/chroot/sources/autoconf-2.52/doc/{autoconf,standards}.info
touch build/chroot/sources/tar-1.22/tests/atlocal.in
touch build/chroot/sources/gawk-3.1.8/doc/gawk{,inet}.info

for f in build/chroot/sources/coreutils-5.0/configure build/chroot/sources/coreutils-5.0/{src,lib}/*.{c,h} \
		build/chroot/sources/coreutils-5.0/m4/*.m4 \
		build/chroot/sources/coreutils-5.0/aclocal.m4 \
		build/chroot/sources/bash-4.4/lib/intl/locale.alias \
		build/chroot/sources/make-3.82/*.{c,h} \
		build/chroot/sources/autoconf-2.52/*.m4 \
		build/chroot/sources/sed-4.0.9/lib/*.c; do
	iconv -f iso-8859-1 -t utf-8 -o build/tmp $f && mv build/tmp $f
done

echo 'all:' >build/chroot/sources/dummy-Makefile
echo 'install:' >>build/chroot/sources/dummy-Makefile

cd build/chroot/sources/coreutils-5.0
mkdir -p man po tests
ln -s ../../dummy-Makefile man/Makefile.in
ln -s ../../dummy-Makefile doc/Makefile.in
ln -s ../../dummy-Makefile po/Makefile.in.in
ln -s ../../dummy-Makefile po/Makefile
ln -s ../../dummy-Makefile tests/Makefile.in
for T in basename chgrp chmod chown cp cut date dd dircolors du expr factor fmt general head install join ln ls ls-2 md5sum misc mkdir mv od pr rm rmdir seq sha1sum shred sort sort-time/Makefile stty sum tac tail tail-2 test touch tr tsort unexpand uniq wc; do
	mkdir -p tests/$T
	echo 'all:' >tests/$T/Makefile.in
	echo 'install:' >>tests/$T/Makefile.in
done
cd ../sed-4.0.9
mkdir -p po testsuite
touch po/Makefile.in.in
ln -s ../../dummy-Makefile testsuite/Makefile.in
ln -s ../../dummy-Makefile po/Makefile
cd ../bash-4.4
mkdir -p doc examples/loadables/perl
ln -s ../../dummy-Makefile doc/Makefile.in
ln -s ../../../dummy-Makefile examples/loadables/Makefile.in
touch examples/loadables/perl/Makefile.in examples/loadables/Makefile.inc.in
cd ../../../..
ln -s ../../dummy-Makefile build/chroot/sources/findutils-4.2.33/po/Makefile.in.in
ln -s ../../dummy-Makefile build/chroot/sources/findutils-4.2.33/po/Makefile
ln -s ../../dummy-Makefile build/chroot/sources/tar-1.22/po/Makefile.in.in
ln -s ../../dummy-Makefile build/chroot/sources/tar-1.22/po/Makefile
ln -s ../../dummy-Makefile build/chroot/sources/tar-1.22/tests/Makefile.in
ln -s ../../dummy-Makefile build/chroot/sources/make-3.82/po/Makefile.in.in
ln -s ../../dummy-Makefile build/chroot/sources/make-3.82/po/Makefile
ln -s ../../dummy-Makefile build/chroot/sources/gawk-3.1.8/po/Makefile.in.in
ln -s ../../dummy-Makefile build/chroot/sources/gawk-3.1.8/po/Makefile
ln -s ../../dummy-Makefile build/chroot/sources/gawk-3.1.8/test/Makefile.in
ln -s ../../dummy-Makefile build/chroot/sources/grep-2.4/po/Makefile.in.in
ln -s ../../dummy-Makefile build/chroot/sources/grep-2.4/po/Makefile
ln -s ../../dummy-Makefile build/chroot/sources/grep-2.4/tests/Makefile.in
ln -s ../../dummy-Makefile build/chroot/sources/grep-2.4/djgpp/Makefile.in
sed 's/;;/;/g' -i build/chroot/sources/bash-4.4/shell.c
perl -CDS -pi -e 's/\x{2264}/<=/g' build/chroot/sources/tar-1.22/lib/mbrtowc.c

find build/chroot -type f -exec chmod a-x {} +

./run-bootstrap.sh part04 "part02 part03" '/opt/part02/bash/bin/bash /sources/bootstrap.sh'
