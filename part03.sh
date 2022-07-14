#!/bin/bash -e
#
# SPDX-FileCopyrightText: 2022 Michael Schierl <schierlm@gmx.de>
#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Part 03: Build linux API headers, glibc, gcc

./get-sources.sh part03

# Create directories
mkdir -p build/chroot/opt/part03/{glibc,gcc}/bin build/chroot/opt/part03/gcc/{lib,include}
PREFIX=build/chroot/opt/part03/api-headers
mkdir -p $PREFIX/include/{asm-generic,drm,misc,mtd,rdma,scsi/fc,sound,video,xen,uapi,asm}
mkdir -p $PREFIX/include/linux/{android,byteorder,caif,can,dvb,hdlc,hsi,isdn,mmc,nfsd,raid,spi,sunrpc,tc_act,tc_ematch,usb,wimax}
mkdir -p $PREFIX/include/linux/netfilter{/ipset,_arp,_bridge,_ipv4,_ipv6}

# Recreate bootstrap tarballs
echo "Recreating bootstrap tarballs"
cp -R build/chroot/sources/bootstrap-tarballs/files/gcc@2.95.3/* build/chroot/sources/gcc-2.95.3/
cp -R build/chroot/sources/bootstrap-tarballs/files/glibc@2.2.5/* build/chroot/sources/glibc-2.2.5/
export FILES=../bootstrap-tarballs/files
cd build/chroot/sources/gcc-2.95.3
${FILES}/gcc@2.95.3.sh
cd ../glibc-2.2.5
${FILES}/glibc@2.2.5.sh
cd ../../../..
unset FILES

# Remove unused files
echo "Removing unused files"
rm -R build/chroot/sources/bootstrap-tarballs
rm -R build/chroot/sources/glibc-2.2.5/{ChangeLog*,iconvdata/testdata,catgets/sample.SJIS,catgets/test*}
rm -R build/chroot/sources/glibc-2.2.5/sysdeps/{[achm]*,i860,i960,ia64,powerpc,rs6000,s390,sparc,tahoe,vax,x86_64,z8000}
rm -R build/chroot/sources/glibc-2.2.5/localedata/{README,ChangeLog*,tst-*.{c,sh,data,input},*.in,tests-mbwc}
rm -R build/chroot/sources/glibc-2.2.5/posix/{PTESTS,TESTS,ptestcases.h,bug-regex*.c,tst-*,PTESTS2C.sed,test*}
rm -R build/chroot/sources/glibc-2.2.5/{intl,libio}/tst*
rm -R build/chroot/sources/glibc-2.2.5/intl/translit.po
rm -R build/chroot/sources/gcc-2.95.3/gcc/{configure.bat,intl/ChangeLog,config/winnt,config/msdos,INSTALL,README*,SERVICE,ChangeLog*}
rm -R build/chroot/sources/gcc-2.95.3/libiberty/{configure.bat,ChangeLog}
rm -R build/chroot/sources/gcc-2.95.3/texinfo/{doc,makeinfo,info}/*.texi
rm -R build/chroot/sources/gcc-2.95.3/{texinfo/intl,include}/ChangeLog
rm -R build/chroot/sources/gcc-2.95.3/config/mpw
rm -R build/chroot/sources/gcc-2.95.3/MAINTAINERS
rm -R build/chroot/sources/linux-4.0/{fs,kernel,MAINTAINERS,tools,Documentation,sound,lib/fonts,drivers}
rm -R build/chroot/sources/linux-4.0/arch/{[abcdfhiKmnopstu]*,xtensa}
rm -R build/chroot/sources/linux-4.0/arch/x86/{[bcKklMmnoprtuvwx]*,ia32}

# Fix files
echo "Fixing files"
mkdir build/chroot/bin build/chroot/sources/linux-4.0/geninc
cp part03/*.sh build/chroot/sources
cp part03/linux_version.h build/chroot/sources/linux-4.0
cp part03/unistd_*.h build/chroot/sources/linux-4.0/geninc
cd build/chroot/bin
ln -s ../opt/part02/bash/bin/bash bash
ln -s bash sh
cd ../sources/glibc-2.2.5
patch -N -p1 -i ../guix-1.3.0/gnu/packages/patches/glibc-boot-2.2.5.patch
cd ../gcc-2.95.3
patch -N -p1 -i ../guix-1.3.0/gnu/packages/patches/gcc-boot-2.95.3.patch
cd ../../../..
rm -R build/chroot/sources/guix-1.3.0
rm -R build/chroot/sources/glibc-2.2.5/manual
sed -i "s/echo '\x1f'/echo -e '\\\\x1f'/g" build/chroot/sources/glibc-2.2.5/configure{,.in}
sed -i 's/^\f\t/\t/' build/chroot/sources/glibc-2.2.5/hurd/hurdsig.c
sed -i 's/\f\f/\f/g' build/chroot/sources/glibc-2.2.5/Makerules
sed -i 's/\f//g' build/chroot/sources/glibc-2.2.5/{glibcbug.in,config.h.in}
LANG=C sed -i 's/^% %.*$/%/g' build/chroot/sources/glibc-2.2.5/localedata/locales/zh_HK
LANG=C sed -i 's/^% Say.*/%/g' build/chroot/sources/glibc-2.2.5/localedata/locales/tr_TR
sed -i 's/\f/\\f/g' build/chroot/sources/gcc-2.95.3/{configure,gcc/configure.lang}
sed -i 's/\f  */\f/g' build/chroot/sources/gcc-2.95.3/gcc/*.c build/chroot/sources/gcc-2.95.3/gcc/config/*/*.{c,md}
sed -i 's/\f\t/\f/g' build/chroot/sources/gcc-2.95.3/gcc/*.c
sed -i 's#\f/#/#g' build/chroot/sources/gcc-2.95.3/gcc/config/*/*.c
sed -i 's/#\f/#/g' build/chroot/sources/gcc-2.95.3/gcc/{fixinc/,}Makefile.in
sed -i 's/;\f/;/g' build/chroot/sources/gcc-2.95.3/gcc/real.c
sed -i 's/\f\f/\f/g' build/chroot/sources/gcc-2.95.3/gcc/libgcc2.c
sed -i 's/\o037/\\037/g' build/chroot/sources/gcc-2.95.3/texinfo/{util/{install-info.c,gen-dir-node,update-info},dir,gen-info-dir,dir-example}
sed -i 's/Author:.*/Author: (removed)/g' build/chroot/sources/linux-4.0/include/{uapi/mtd/ubi-user.h,linux/mtd/ubi.h}
sed -i 's/\xc2\xa0/ /g' build/chroot/sources/linux-4.0/include/linux/ide.h

patch -d build/chroot/sources/linux-4.0 -N -p1 -i ../../../../part03/unifdef.patch
patch -d build/chroot/sources/gcc-2.95.3 -N -p1 -i ../../../../part03/gcc-2.95.3-make-without-tar.patch

for DIR in build/chroot/sources/glibc-2.2.5/po  build/chroot/sources/gcc-2.95.3/texinfo/{po,emacs}; do
	rm -R $DIR
	mkdir -p $DIR
	echo 'all:' >$DIR/Makefile
	echo 'install:' >>$DIR/Makefile
done
for f in build/chroot/sources/glibc-2.2.5/{malloc,sysdeps/posix,sysdeps/i386/fpu,localedata,sunrpc,string}/*.{c,h,S} \
    build/chroot/sources/glibc-2.2.5/{intl/locale.alias,locale/iso-639.def} \
    build/chroot/sources/glibc-2.2.5/localedata/locales/{gv_GB,cs_CZ,sk_SK,se_NO,sv_SE,ka_GE,gl_ES,gd_GB,kw_GB,iso14651_t1}; do
	[ -s "${f}" ] || continue
	iconv -f iso-8859-1 -t utf-8 -o build/tmp $f && mv build/tmp $f
done
for f in build/chroot/sources/linux-4.0/fs/ubifs/sb.c; do
	[ -s "${f}" ] || continue
	iconv -f iso-8859-1 -t utf-8 -o build/tmp $f && mv build/tmp $f
done

find build/chroot -type f -exec chmod a-x {} +

./run-bootstrap.sh part03 "part01 part02" './opt/part02/bash/bin/bash /sources/bootstrap.sh'
