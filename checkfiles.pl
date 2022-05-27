#!/usr/bin/env perl
#
# SPDX-FileCopyrightText: 2022 Michael Schierl <schierlm@gmx.de>
#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Check that input directory only contains correct/auditable files
#
use warnings;
use strict;
use PerlIO::encoding;
use Encode;
use Data::Dumper;

sub scandir {
	my $basedir=$_[0];
	opendir my $dir,$basedir or die $!;
	while (my $f = readdir($dir)) {
		my $file="$basedir/$f";
		if (-l $file) {
			my $target=readlink($file);
			die "Absolute symlink $file linking to $target" if $target =~ m#^/#;
		} elsif (-d $file) {
			my $perms = sprintf "%o", (stat($file))[2] & 0777;
			die "Incorrect directory permissions $perms of $file" unless $perms eq '755';
			scandir($file) unless $file =~ /\.$/;
		} elsif (-f $file) {
			my $perms = sprintf "%o", (stat($file))[2] & 0777;
			die "Incorrect file permissions $perms of $file" unless $perms == '644';
			eval {
				open my $fh, "<:encoding(UTF-8)", $file or die "Cannot open $file: $!\n";
				while(<$fh>) {
					die "Invalid characters in " . Data::Dumper::qquote($_)
						unless $_ =~ /^(\f|[\a\t\x{0020}-\x{007E}\x{00A1}-\x{017F}\x{03b1}\x{2010}-\x{2026}]*)$/;
				}
				close $fh;
				1
			} or do {
				die "Error parsing file $file: $@";
			};
		} else {
			die "Unsupported file type: $file";
		}
	}
	closedir($dir);
}

$PerlIO::encoding::fallback = Encode::FB_CROAK;
scandir($ARGV[0]);
