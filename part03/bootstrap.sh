#!/bin/sh

# SPDX-FileCopyrightText: 2022 Michael Schierl <schierlm@gmx.de>
#
# SPDX-License-Identifier: GPL-3.0-or-later

set -ex

export PATH=${PATH}:/opt/part02/tcc2/bin:/opt/part02/make/bin:/opt/part02/coreutils/bin:/opt/part02/bash/bin:/opt/part02/gzip/bin:/opt/part02/sed/bin:/opt/part02/patch.bin:/opt/part02/bzip2/bin:/opt/part02/grep/bin:/opt/part02/gawk/bin:/opt/part02/binutils/bin

### linux-api-headers 4.0 ###

PREFIX=/opt/part03/api-headers
cd /sources/linux-4.0
tcc -o scripts/unifdef scripts/unifdef.c -lgetopt

cp linux_version.h $PREFIX/include/linux/version.h
bash scripts/headers_install.sh $PREFIX/include/asm ./geninc unistd_32.h unistd_64.h unistd_x32.h unistd_32.h unistd_64.h unistd_x32.h
bash scripts/headers_install.sh $PREFIX/include/asm-generic ./include/uapi/asm-generic auxvec.h bitsperlong.h errno-base.h errno.h fcntl.h int-l64.h int-ll64.h ioctl.h ioctls.h ipcbuf.h kvm_para.h mman-common.h mman.h msgbuf.h param.h poll.h posix_types.h resource.h sembuf.h setup.h shmbuf.h shmparam.h siginfo.h signal-defs.h signal.h socket.h sockios.h stat.h statfs.h swab.h termbits.h termios.h types.h ucontext.h unistd.h
bash scripts/headers_install.sh $PREFIX/include/asm-generic ./include/asm-generic
bash scripts/headers_install.sh $PREFIX/include/asm-generic ./include/generated/uapi/asm-generic
bash scripts/headers_install.sh $PREFIX/include/drm ./include/uapi/drm drm.h drm_fourcc.h drm_mode.h drm_sarea.h exynos_drm.h i810_drm.h i915_drm.h mga_drm.h msm_drm.h nouveau_drm.h qxl_drm.h r128_drm.h radeon_drm.h savage_drm.h sis_drm.h tegra_drm.h via_drm.h vmwgfx_drm.h
bash scripts/headers_install.sh $PREFIX/include/drm ./include/drm
bash scripts/headers_install.sh $PREFIX/include/drm ./include/generated/uapi/drm
bash scripts/headers_install.sh $PREFIX/include/linux/android ./include/uapi/linux/android binder.h
bash scripts/headers_install.sh $PREFIX/include/linux/android ./include/linux/android
bash scripts/headers_install.sh $PREFIX/include/linux/android ./include/generated/uapi/linux/android
bash scripts/headers_install.sh $PREFIX/include/linux/byteorder ./include/uapi/linux/byteorder big_endian.h little_endian.h
bash scripts/headers_install.sh $PREFIX/include/linux/byteorder ./include/linux/byteorder
bash scripts/headers_install.sh $PREFIX/include/linux/byteorder ./include/generated/uapi/linux/byteorder
bash scripts/headers_install.sh $PREFIX/include/linux/caif ./include/uapi/linux/caif caif_socket.h if_caif.h
bash scripts/headers_install.sh $PREFIX/include/linux/caif ./include/linux/caif
bash scripts/headers_install.sh $PREFIX/include/linux/caif ./include/generated/uapi/linux/caif
bash scripts/headers_install.sh $PREFIX/include/linux/can ./include/uapi/linux/can bcm.h error.h gw.h netlink.h raw.h
bash scripts/headers_install.sh $PREFIX/include/linux/can ./include/linux/can
bash scripts/headers_install.sh $PREFIX/include/linux/can ./include/generated/uapi/linux/can
bash scripts/headers_install.sh $PREFIX/include/linux/dvb ./include/uapi/linux/dvb audio.h ca.h dmx.h frontend.h net.h osd.h version.h video.h
bash scripts/headers_install.sh $PREFIX/include/linux/dvb ./include/linux/dvb
bash scripts/headers_install.sh $PREFIX/include/linux/dvb ./include/generated/uapi/linux/dvb
bash scripts/headers_install.sh $PREFIX/include/linux/hdlc ./include/uapi/linux/hdlc ioctl.h
bash scripts/headers_install.sh $PREFIX/include/linux/hdlc ./include/linux/hdlc
bash scripts/headers_install.sh $PREFIX/include/linux/hdlc ./include/generated/uapi/linux/hdlc
bash scripts/headers_install.sh $PREFIX/include/linux/hsi ./include/uapi/linux/hsi hsi_char.h
bash scripts/headers_install.sh $PREFIX/include/linux/hsi ./include/linux/hsi
bash scripts/headers_install.sh $PREFIX/include/linux/hsi ./include/generated/uapi/linux/hsi
bash scripts/headers_install.sh $PREFIX/include/linux/isdn ./include/uapi/linux/isdn capicmd.h
bash scripts/headers_install.sh $PREFIX/include/linux/isdn ./include/linux/isdn
bash scripts/headers_install.sh $PREFIX/include/linux/isdn ./include/generated/uapi/linux/isdn
bash scripts/headers_install.sh $PREFIX/include/linux/mmc ./include/uapi/linux/mmc ioctl.h
bash scripts/headers_install.sh $PREFIX/include/linux/mmc ./include/linux/mmc
bash scripts/headers_install.sh $PREFIX/include/linux/mmc ./include/generated/uapi/linux/mmc
bash scripts/headers_install.sh $PREFIX/include/linux/netfilter/ipset ./include/uapi/linux/netfilter/ipset ip_set.h ip_set_bitmap.h ip_set_hash.h ip_set_list.h
bash scripts/headers_install.sh $PREFIX/include/linux/netfilter/ipset ./include/linux/netfilter/ipset
bash scripts/headers_install.sh $PREFIX/include/linux/netfilter/ipset ./include/generated/uapi/linux/netfilter/ipset
bash scripts/headers_install.sh $PREFIX/include/linux/netfilter ./include/uapi/linux/netfilter nf_conntrack_common.h nf_conntrack_ftp.h nf_conntrack_sctp.h nf_conntrack_tcp.h nf_conntrack_tuple_common.h nf_nat.h nf_tables.h nf_tables_compat.h nfnetlink.h nfnetlink_acct.h nfnetlink_compat.h nfnetlink_conntrack.h nfnetlink_cthelper.h nfnetlink_cttimeout.h nfnetlink_log.h nfnetlink_queue.h x_tables.h xt_AUDIT.h xt_CHECKSUM.h xt_CLASSIFY.h xt_CONNMARK.h xt_CONNSECMARK.h xt_CT.h xt_DSCP.h xt_HMARK.h xt_IDLETIMER.h xt_LED.h xt_LOG.h xt_MARK.h xt_NFLOG.h xt_NFQUEUE.h xt_RATEEST.h xt_SECMARK.h xt_TCPMSS.h xt_TCPOPTSTRIP.h xt_TEE.h xt_TPROXY.h xt_addrtype.h xt_bpf.h xt_cgroup.h xt_cluster.h xt_comment.h xt_connbytes.h xt_connlabel.h xt_connlimit.h xt_connmark.h xt_conntrack.h xt_cpu.h xt_dccp.h xt_devgroup.h xt_dscp.h xt_ecn.h xt_esp.h xt_hashlimit.h xt_helper.h xt_ipcomp.h xt_iprange.h xt_ipvs.h xt_l2tp.h xt_length.h xt_limit.h xt_mac.h xt_mark.h xt_multiport.h xt_nfacct.h xt_osf.h xt_owner.h xt_physdev.h xt_pkttype.h xt_policy.h xt_quota.h xt_rateest.h xt_realm.h xt_recent.h xt_rpfilter.h xt_sctp.h xt_set.h xt_socket.h xt_state.h xt_statistic.h xt_string.h xt_tcpmss.h xt_tcpudp.h xt_time.h xt_u32.h
bash scripts/headers_install.sh $PREFIX/include/linux/netfilter ./include/linux/netfilter
bash scripts/headers_install.sh $PREFIX/include/linux/netfilter ./include/generated/uapi/linux/netfilter
bash scripts/headers_install.sh $PREFIX/include/linux/netfilter_arp ./include/uapi/linux/netfilter_arp arp_tables.h arpt_mangle.h
bash scripts/headers_install.sh $PREFIX/include/linux/netfilter_arp ./include/linux/netfilter_arp
bash scripts/headers_install.sh $PREFIX/include/linux/netfilter_arp ./include/generated/uapi/linux/netfilter_arp
bash scripts/headers_install.sh $PREFIX/include/linux/netfilter_bridge ./include/uapi/linux/netfilter_bridge ebt_802_3.h ebt_among.h ebt_arp.h ebt_arpreply.h ebt_ip.h ebt_ip6.h ebt_limit.h ebt_log.h ebt_mark_m.h ebt_mark_t.h ebt_nat.h ebt_nflog.h ebt_pkttype.h ebt_redirect.h ebt_stp.h ebt_vlan.h ebtables.h
bash scripts/headers_install.sh $PREFIX/include/linux/netfilter_bridge ./include/linux/netfilter_bridge
bash scripts/headers_install.sh $PREFIX/include/linux/netfilter_bridge ./include/generated/uapi/linux/netfilter_bridge
bash scripts/headers_install.sh $PREFIX/include/linux/netfilter_ipv4 ./include/uapi/linux/netfilter_ipv4 ip_tables.h ipt_CLUSTERIP.h ipt_ECN.h ipt_LOG.h ipt_REJECT.h ipt_TTL.h ipt_ah.h ipt_ecn.h ipt_ttl.h
bash scripts/headers_install.sh $PREFIX/include/linux/netfilter_ipv4 ./include/linux/netfilter_ipv4
bash scripts/headers_install.sh $PREFIX/include/linux/netfilter_ipv4 ./include/generated/uapi/linux/netfilter_ipv4
bash scripts/headers_install.sh $PREFIX/include/linux/netfilter_ipv6 ./include/uapi/linux/netfilter_ipv6 ip6_tables.h ip6t_HL.h ip6t_LOG.h ip6t_NPT.h ip6t_REJECT.h ip6t_ah.h ip6t_frag.h ip6t_hl.h ip6t_ipv6header.h ip6t_mh.h ip6t_opts.h ip6t_rt.h
bash scripts/headers_install.sh $PREFIX/include/linux/netfilter_ipv6 ./include/linux/netfilter_ipv6
bash scripts/headers_install.sh $PREFIX/include/linux/netfilter_ipv6 ./include/generated/uapi/linux/netfilter_ipv6
bash scripts/headers_install.sh $PREFIX/include/linux/nfsd ./include/uapi/linux/nfsd cld.h debug.h export.h nfsfh.h stats.h
bash scripts/headers_install.sh $PREFIX/include/linux/nfsd ./include/linux/nfsd
bash scripts/headers_install.sh $PREFIX/include/linux/nfsd ./include/generated/uapi/linux/nfsd
bash scripts/headers_install.sh $PREFIX/include/linux/raid ./include/uapi/linux/raid md_p.h md_u.h
bash scripts/headers_install.sh $PREFIX/include/linux/raid ./include/linux/raid
bash scripts/headers_install.sh $PREFIX/include/linux/raid ./include/generated/uapi/linux/raid
bash scripts/headers_install.sh $PREFIX/include/linux/spi ./include/uapi/linux/spi spidev.h
bash scripts/headers_install.sh $PREFIX/include/linux/spi ./include/linux/spi
bash scripts/headers_install.sh $PREFIX/include/linux/spi ./include/generated/uapi/linux/spi
bash scripts/headers_install.sh $PREFIX/include/linux/sunrpc ./include/uapi/linux/sunrpc debug.h
bash scripts/headers_install.sh $PREFIX/include/linux/sunrpc ./include/linux/sunrpc
bash scripts/headers_install.sh $PREFIX/include/linux/sunrpc ./include/generated/uapi/linux/sunrpc
bash scripts/headers_install.sh $PREFIX/include/linux/tc_act ./include/uapi/linux/tc_act tc_bpf.h tc_connmark.h tc_csum.h tc_defact.h tc_gact.h tc_ipt.h tc_mirred.h tc_nat.h tc_pedit.h tc_skbedit.h tc_vlan.h
bash scripts/headers_install.sh $PREFIX/include/linux/tc_act ./include/linux/tc_act
bash scripts/headers_install.sh $PREFIX/include/linux/tc_act ./include/generated/uapi/linux/tc_act
bash scripts/headers_install.sh $PREFIX/include/linux/tc_ematch ./include/uapi/linux/tc_ematch tc_em_cmp.h tc_em_meta.h tc_em_nbyte.h tc_em_text.h
bash scripts/headers_install.sh $PREFIX/include/linux/tc_ematch ./include/linux/tc_ematch
bash scripts/headers_install.sh $PREFIX/include/linux/tc_ematch ./include/generated/uapi/linux/tc_ematch
bash scripts/headers_install.sh $PREFIX/include/linux/usb ./include/uapi/linux/usb audio.h cdc-wdm.h cdc.h ch11.h ch9.h functionfs.h g_printer.h gadgetfs.h midi.h tmc.h video.h
bash scripts/headers_install.sh $PREFIX/include/linux/usb ./include/linux/usb
bash scripts/headers_install.sh $PREFIX/include/linux/usb ./include/generated/uapi/linux/usb
bash scripts/headers_install.sh $PREFIX/include/linux/wimax ./include/uapi/linux/wimax i2400m.h
bash scripts/headers_install.sh $PREFIX/include/linux/wimax ./include/linux/wimax
bash scripts/headers_install.sh $PREFIX/include/linux/wimax ./include/generated/uapi/linux/wimax
bash scripts/headers_install.sh $PREFIX/include/linux ./include/uapi/linux a.out.h acct.h adb.h adfs_fs.h affs_hardblocks.h agpgart.h aio_abi.h am437x-vpfe.h apm_bios.h arcfb.h atalk.h atm.h atm_eni.h atm_he.h atm_idt77105.h atm_nicstar.h atm_tcp.h atm_zatm.h atmapi.h atmarp.h atmbr2684.h atmclip.h atmdev.h atmioc.h atmlec.h atmmpc.h atmppp.h atmsap.h atmsvc.h audit.h auto_fs.h auto_fs4.h auxvec.h ax25.h b1lli.h baycom.h bcm933xx_hcs.h bfs_fs.h binfmts.h blkpg.h blktrace_api.h bpf.h bpf_common.h bpqether.h bsg.h btrfs.h can.h capability.h capi.h cciss_defs.h cciss_ioctl.h cdrom.h cgroupstats.h chio.h cm4000_cs.h cn_proc.h coda.h coda_psdev.h coff.h connector.h const.h cramfs_fs.h cuda.h cyclades.h cycx_cfm.h dcbnl.h dccp.h dlm.h dlm_device.h dlm_netlink.h dlm_plock.h dlmconstants.h dm-ioctl.h dm-log-userspace.h dn.h dqblk_xfs.h edd.h efs_fs_sb.h elf-em.h elf-fdpic.h elf.h elfcore.h errno.h errqueue.h ethtool.h eventpoll.h fadvise.h falloc.h fanotify.h fb.h fcntl.h fd.h fdreg.h fib_rules.h fiemap.h filter.h firewire-cdev.h firewire-constants.h flat.h fou.h fs.h fsl_hypervisor.h fuse.h futex.h gameport.h gen_stats.h genetlink.h gfs2_ondisk.h gigaset_dev.h hdlc.h hdlcdrv.h hdreg.h hid.h hiddev.h hidraw.h hpet.h hsr_netlink.h hw_breakpoint.h hyperv.h hysdn_if.h i2c-dev.h i2c.h i2o-dev.h i8k.h icmp.h icmpv6.h if.h if_addr.h if_addrlabel.h if_alg.h if_arcnet.h if_arp.h if_bonding.h if_bridge.h if_cablemodem.h if_eql.h if_ether.h if_fc.h if_fddi.h if_frad.h if_hippi.h if_infiniband.h if_link.h if_ltalk.h if_packet.h if_phonet.h if_plip.h if_ppp.h if_pppol2tp.h if_pppox.h if_slip.h if_team.h if_tun.h if_tunnel.h if_vlan.h if_x25.h igmp.h in.h in6.h in_route.h inet_diag.h inotify.h input.h ioctl.h ip.h ip6_tunnel.h ip_vs.h ipc.h ipmi.h ipmi_msgdefs.h ipsec.h ipv6.h ipv6_route.h ipx.h irda.h irqnr.h isdn.h isdn_divertif.h isdn_ppp.h isdnif.h iso_fs.h ivtv.h ivtvfb.h ixjuser.h jffs2.h joystick.h kcmp.h kd.h kdev_t.h kernel-page-flags.h kernel.h kernelcapi.h kexec.h keyboard.h keyctl.h kvm.h kvm_para.h l2tp.h libc-compat.h limits.h llc.h loop.h lp.h magic.h major.h map_to_7segment.h matroxfb.h mdio.h media-bus-format.h media.h mei.h memfd.h mempolicy.h meye.h mic_common.h mic_ioctl.h mii.h minix_fs.h mman.h mmtimer.h mpls.h mqueue.h mroute.h mroute6.h msdos_fs.h msg.h mtio.h n_r3964.h nbd.h ncp.h ncp_fs.h ncp_mount.h ncp_no.h neighbour.h net.h net_dropmon.h net_namespace.h net_tstamp.h netconf.h netdevice.h netfilter.h netfilter_arp.h netfilter_bridge.h netfilter_decnet.h netfilter_ipv4.h netfilter_ipv6.h netlink.h netlink_diag.h netrom.h nfc.h nfs.h nfs2.h nfs3.h nfs4.h nfs4_mount.h nfs_fs.h nfs_idmap.h nfs_mount.h nfsacl.h nl80211.h nubus.h nvme.h nvram.h omap3isp.h omapfb.h oom.h openvswitch.h packet_diag.h param.h parport.h patchkey.h pci.h pci_regs.h perf_event.h personality.h pfkeyv2.h pg.h phantom.h phonet.h pkt_cls.h pkt_sched.h pktcdvd.h pmu.h poll.h posix_types.h ppdev.h ppp-comp.h ppp-ioctl.h ppp_defs.h pps.h prctl.h psci.h ptp_clock.h ptrace.h qnx4_fs.h qnxtypes.h quota.h radeonfb.h random.h raw.h rds.h reboot.h reiserfs_fs.h reiserfs_xattr.h resource.h rfkill.h romfs_fs.h rose.h route.h rtc.h rtnetlink.h scc.h sched.h screen_info.h sctp.h sdla.h seccomp.h securebits.h selinux_netlink.h sem.h serial.h serial_core.h serial_reg.h serio.h shm.h signal.h signalfd.h smiapp.h snmp.h sock_diag.h socket.h sockios.h sonet.h sonypi.h sound.h soundcard.h stat.h stddef.h string.h suspend_ioctls.h swab.h synclink.h sysctl.h sysinfo.h target_core_user.h taskstats.h tcp.h tcp_metrics.h telephony.h termios.h thermal.h time.h times.h timex.h tiocl.h tipc.h tipc_config.h tipc_netlink.h toshiba.h tty.h tty_flags.h types.h udf_fs_i.h udp.h uhid.h uinput.h uio.h ultrasound.h un.h unistd.h unix_diag.h usbdevice_fs.h usbip.h utime.h utsname.h uuid.h uvcvideo.h v4l2-common.h v4l2-controls.h v4l2-dv-timings.h v4l2-mediabus.h v4l2-subdev.h veth.h vfio.h vhost.h videodev2.h virtio_9p.h virtio_balloon.h virtio_blk.h virtio_config.h virtio_console.h virtio_ids.h virtio_net.h virtio_pci.h virtio_ring.h virtio_rng.h virtio_scsi.h virtio_types.h vm_sockets.h vt.h wait.h wanrouter.h watchdog.h wimax.h wireless.h x25.h xattr.h xfrm.h zorro.h zorro_ids.h
bash scripts/headers_install.sh $PREFIX/include/linux ./include/linux
bash scripts/headers_install.sh $PREFIX/include/misc ./include/uapi/misc cxl.h
bash scripts/headers_install.sh $PREFIX/include/misc ./include/misc
bash scripts/headers_install.sh $PREFIX/include/misc ./include/generated/uapi/misc
bash scripts/headers_install.sh $PREFIX/include/mtd ./include/uapi/mtd inftl-user.h mtd-abi.h mtd-user.h nftl-user.h ubi-user.h
bash scripts/headers_install.sh $PREFIX/include/mtd ./include/mtd
bash scripts/headers_install.sh $PREFIX/include/mtd ./include/generated/uapi/mtd
bash scripts/headers_install.sh $PREFIX/include/rdma ./include/uapi/rdma ib_user_cm.h ib_user_mad.h ib_user_sa.h ib_user_verbs.h rdma_netlink.h rdma_user_cm.h
bash scripts/headers_install.sh $PREFIX/include/rdma ./include/rdma
bash scripts/headers_install.sh $PREFIX/include/rdma ./include/generated/uapi/rdma
bash scripts/headers_install.sh $PREFIX/include/scsi/fc ./include/uapi/scsi/fc fc_els.h fc_fs.h fc_gs.h fc_ns.h
bash scripts/headers_install.sh $PREFIX/include/scsi/fc ./include/scsi/fc
bash scripts/headers_install.sh $PREFIX/include/scsi/fc ./include/generated/uapi/scsi/fc
bash scripts/headers_install.sh $PREFIX/include/scsi ./include/uapi/scsi scsi_bsg_fc.h scsi_netlink.h scsi_netlink_fc.h
bash scripts/headers_install.sh $PREFIX/include/scsi ./include/scsi
bash scripts/headers_install.sh $PREFIX/include/scsi ./include/generated/uapi/scsi
bash scripts/headers_install.sh $PREFIX/include/sound ./include/uapi/sound asequencer.h asound.h asound_fm.h compress_offload.h compress_params.h emu10k1.h firewire.h hdsp.h hdspm.h sb16_csp.h sfnt_info.h
bash scripts/headers_install.sh $PREFIX/include/sound ./include/sound
bash scripts/headers_install.sh $PREFIX/include/sound ./include/generated/uapi/sound
bash scripts/headers_install.sh $PREFIX/include/video ./include/uapi/video edid.h sisfb.h uvesafb.h
bash scripts/headers_install.sh $PREFIX/include/video ./include/video
bash scripts/headers_install.sh $PREFIX/include/video ./include/generated/uapi/video
bash scripts/headers_install.sh $PREFIX/include/xen ./include/uapi/xen evtchn.h gntalloc.h gntdev.h privcmd.h
bash scripts/headers_install.sh $PREFIX/include/xen ./include/xen
bash scripts/headers_install.sh $PREFIX/include/xen ./include/generated/uapi/xen
bash scripts/headers_install.sh $PREFIX/include/uapi ./include/uapi
bash scripts/headers_install.sh $PREFIX/include/uapi ./include
bash scripts/headers_install.sh $PREFIX/include/uapi ./include/generated/uapi
bash scripts/headers_install.sh $PREFIX/include/asm ./arch/x86/include/uapi/asm a.out.h auxvec.h bitsperlong.h boot.h bootparam.h byteorder.h debugreg.h e820.h errno.h fcntl.h hw_breakpoint.h hyperv.h ioctl.h ioctls.h ipcbuf.h ist.h kvm.h kvm_para.h kvm_perf.h ldt.h mce.h mman.h msgbuf.h msr-index.h msr.h mtrr.h param.h perf_regs.h poll.h posix_types.h posix_types_32.h posix_types_64.h posix_types_x32.h prctl.h processor-flags.h ptrace-abi.h ptrace.h resource.h sembuf.h setup.h shmbuf.h sigcontext.h sigcontext32.h siginfo.h signal.h socket.h sockios.h stat.h statfs.h svm.h swab.h termbits.h termios.h types.h ucontext.h unistd.h vm86.h vmx.h vsyscall.h
bash scripts/headers_install.sh $PREFIX/include/asm ./arch/x86/include/asm
unset PREFIX

### gcc 2.95 ###
mkdir -p /sources/gcc-2.95.3/build1 /opt/part03tmp/gcc /tmp
cd /sources/gcc-2.95.3
rm -R texinfo
mkdir -p texinfo
echo 'all:'>texinfo/Makefile.in
echo 'install:'>>texinfo/Makefile.in
touch gcc/README-fixinc
chmod a+x configure config.guess ltconfig install-sh move-if-change mkinstalldirs symlink-tree config.sub ylwrap missing \
  */configure */config.guess */fixproto */move-if-change \
  gcc/fixinc/fixinc.svr4 gcc/fixinc/fixinc.dgux gcc/fixinc/mkfixinc.sh gcc/fixinc/fixinc.wrap gcc/fixinc/genfixes gcc/fixinc/fixinc.irix \
  gcc/fixinc/fixinc.sco gcc/fixinc/inclhack.sh gcc/fixinc/fixincl.sh gcc/dostage2 gcc/dostage3 gcc/fixcpp \
  gcc/intl/po2tbl.sed.in gcc/intl/linux-msg.sed gcc/intl/xopen-msg.sed gcc/patch-apollo-includes gcc/sort-protos gcc/just-fixinc \
  gcc/scan-types.sh gcc/listing gcc/config/m88k/m88k-move.sh gcc/fixincludes gcc/exgettext \
  contrib/egcs_update contrib/test_summary contrib/compare_tests contrib/index-prop contrib/test_installed contrib/warn_summary \
  libiberty/testsuite/regress-demangle
cd build1
export CONFIG_SHELL=/opt/part02/bash/bin/bash
export CPPFLAGS=" -D __GLIBC_MINOR__=6"
export CC="tcc -D __GLIBC_MINOR__=6"
export CC_FOR_BUILD="tcc -D __GLIBC_MINOR__=6"
export CPP="tcc -E -D __GLIBC_MINOR__=6"
echo "ac_cv_c_float_format='IEEE (little-endian)'" >config.cache
echo "ac_cv_c_float_format='IEEE (little-endian)'" >../config.cache
../configure --enable-static --disable-shared --disable-werror --build=i686-unknown-linux-gnu --host=i686-unknown-linux-gnu --prefix=/opt/part03tmp/gcc
touch gcc/cpp.info gcc/gcc.info
make CC="tcc -static -D __GLIBC_MINOR__=6" OLDCC="tcc -static -D __GLIBC_MINOR__=6" CC_FOR_BUILD="tcc -static -D __GLIBC_MINOR__=6" AR=ar RANLIB=ranlib LIBGCC2_INCLUDES="-I /opt/part01/mes/include" LANGUAGES=c BOOT_LDFLAGS=" -B /opt/part02/tcc2/lib/"
make install
mkdir -p tmp
cd tmp
ar x ../gcc/libgcc2.a
ar r /opt/part03tmp/gcc/lib/gcc-lib/i686-unknown-linux-gnu/2.95.3/libgcc.a *.o
cd ..
cp gcc/libgcc2.a /opt/part03tmp/gcc/lib/libgcc2.a
unset CC_FOR_BUILD

export PATH=/opt/part03tmp/gcc/bin:${PATH}

### glibc 2.2.5 ###
mkdir -p /opt/part03/glibc
cd /sources/glibc-2.2.5
touch po/de.po
chmod a+x configure */*/configure */*/*/configure */*/*/*/*/configure \
  scripts/test-installation.pl scripts/rellns-sh scripts/config.guess scripts/gen-sorted.awk scripts/install-sh scripts/move-if-change \
  scripts/gen-FAQ.pl scripts/mkinstalldirs scripts/config.sub scripts/cpp malloc/tst-mtrace.sh malloc/memusage.sh sysdeps/unix/snarf-ioctls \
  debug/xtrace.sh debug/catchsegv.sh stdio-common/tst-unbputc.sh posix/globtest.sh posix/wordexp-tst.sh elf/tst-pathopt.sh iconvdata/tst-table.sh \
  iconvdata/tst-tables.sh iconvdata/tst-table-charmap.sh iconvdata/run-iconv-test.sh catgets/xopen-msg.sed libio/test-freopen.sh \
  math/gen-libm-test.pl stdlib/tst-fmtmsg.sh timezone/yearistype
export CONFIG_SHELL=/opt/part02/bash/bin/bash
export SHELL=/opt/part02/bash/bin/bash
export CPPFLAGS=" -D __STDC__=1 -D MES_BOOTSTRAP=1 -D BOOTSTRAP_GLIBC=1"
export CC="gcc -D __STDC__=1 -D MES_BOOTSTRAP=1 -D BOOTSTRAP_GLIBC=1 -L /sources/glibc-2.2.5"
export CPP="gcc -E -D __STDC__=1 -D MES_BOOTSTRAP=1 -D BOOTSTRAP_GLIBC=1"
./configure --disable-shared --enable-static --disable-sanity-checks --build=i686-unknown-linux-gnu --host=i686-unknown-linux-gnu --with-headers=/opt/part03/api-headers/include --enable-static-nss --without-__thread --without-cvs --without-gd --without-tls --prefix=/opt/part03/glibc
mkdir -p manual
echo 'subdir_lib:' >manual/Makefile
echo 'others:' >>manual/Makefile
echo 'subdir_install:' >>manual/Makefile
echo 'subdir_lib:' >po/Makefile
echo 'others:' >>po/Makefile
echo 'subdir_install:' >>po/Makefile
touch manual/errno.texi manual/stamp.o po/stamp.o
touch posix/testcases.h posix/ptestcases.h posix/PTESTS posix/TESTS
echo p >posix/PTESTS2C.sed
echo p >posix/TESTS2C.sed
# work around touch not setting the mtime
mv sysdeps/gnu/errlist.c sysdeps/gnu/errlist.c_orig
cp sysdeps/gnu/errlist.c_orig sysdeps/gnu/errlist.c
rm sysdeps/gnu/errlist.c_orig
make SHELL=/opt/part02/bash/bin/bash
touch localedata/collate-test.d localedata/xfrm-test.d localedata/tst-fmon.d localedata/tst-rpmatch.d localedata/tst-trans.d
touch localedata/tst-mbswcs1.d localedata/tst-mbswcs2.d localedata/tst-mbswcs3.d localedata/tst-mbswcs4.d localedata/tst-mbswcs5.d
touch localedata/tst-ctype.d localedata/tst-wctype.d localedata/tst-langinfo.d
touch intl/tst-gettext.d intl/tst-translit.d intl/tst-gettext2.d intl/tst-codeset.d intl/tst-ngettext.d
touch catgets/tst-catgets.d catgets/test-gencat.d libio/tst_swprintf.d libio/tst_wprintf.d libio/tst_swscanf.d libio/tst_wscanf.d
touch libio/tst_getwc.d libio/tst_putwc.d libio/tst_wprintf2.d libio/tst-widetext.d libio/tst-ext.d libio/tst-fopenloc.d libio/tst-fgetws.d
touch libio/tst-ungetwc1.d libio/tst-ungetwc2.d libio/tst-swscanf.d libio/tst-sscanf.d
touch posix/bug-regex1.d posix/bug-regex2.d posix/bug-regex3.d posix/bug-regex4.d posix/bug-regex5.d posix/testfnm.d posix/test-vfork.d
touch posix/tst-chmod.d posix/tst-dir.d posix/tst-exec.d posix/tst-fnmatch.d posix/tst-fork.d posix/tst-getaddrinfo.d posix/tst-getconf.sh
touch posix/tst-getlogin.d posix/tst-gnuglob.d posix/tst-mmap.d posix/tst-preadwrite64.d posix/tst-preadwrite.d posix/tst-regex.d
touch posix/tst-regexloc.d posix/tst-spawn.d posix/tst-truncate64.d posix/tst-truncate.d
touch manual/stubs po/stubs
make install
unset CPPFLAGS
unset CC
unset CPP

export PATH=/opt/part03/glibc/bin:$PATH
cd /opt/part03/gcc/lib
ln -s ../../glibc/lib/* .
cd ../include
ln -s ../../glibc/include/* .
rm scsi
ln -s ../../api-headers/include/* .
rm scsi
mkdir scsi
cd scsi
ln -s ../../../glibc/include/scsi/* .
ln -s ../../../glibc/api-headers/scsi/* .
cd /opt/part03tmp/gcc/lib
ln -s ../../../part03/gcc/lib/* .
cd /opt/part03tmp/gcc/include
ln -s ../../../part03/gcc/include/* .

### gcc 2.95 ###
mkdir -p /sources/gcc-2.95.3/build2
cd /sources/gcc-2.95.3/build2
export CONFIG_SHELL=/opt/part02/bash/bin/bash
echo "ac_cv_c_float_format='IEEE (little-endian)'" >config.cache
../configure --disable-shared --disable-werror --build=i686-unknown-linux-gnu --host=i686-unknown-linux-gnu --prefix=/opt/part03/gcc
touch gcc/cpp.info gcc/gcc.info
make RANLIB=true LIBGCC2_INCLUDES="-I /opt/part03/glibc/include" LANGUAGES=c
make install
mkdir -p tmp
cd tmp
ar x ../gcc/libgcc2.a
ar r /opt/part03/gcc/lib/gcc-lib/i686-unknown-linux-gnu/2.95.3/libgcc.a *.o
cd ..
cp gcc/libgcc2.a /opt/part03/gcc/lib/libgcc2.a

export PATH=/opt/part03/gcc/bin:${PATH}
