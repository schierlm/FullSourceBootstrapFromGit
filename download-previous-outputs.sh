#!/bin/bash -e
#
# SPDX-FileCopyrightText: 2022 Michael Schierl <schierlm@gmx.de>
#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Download outputs from previous parts (listed in first command line argument) from GitHub releases.

mkdir -p cache
for dep in $1; do
	wget -P cache -nc "https://github.com/schierlm/FullSourceBootstrapFromGit/releases/download/${dep}-artifacts/${dep}-output.tar.xz"
done
