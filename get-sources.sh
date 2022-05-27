#!/bin/bash
#
# SPDX-FileCopyrightText: 2022 Michael Schierl <schierlm@gmx.de>
#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Load repositories for part named in $1.

PART=$1

function repo() {
	FORPART=$1
	[ "${PART}" == "${FORPART}" ] || return
	DESTDIR=$2
	URL=$3
	BRANCH=$4
	COMMIT=$5

	if [ ! -d "cache/$COMMIT" ]; then
		echo "Retrieving from ${URL}..."
		mkdir -p "cache/${COMMIT}"
		cd "cache/${COMMIT}"
		git init --initial-branch=main
		git remote add origin "${URL}"
		git fetch --depth 1 origin "${BRANCH}"
		git checkout --detach FETCH_HEAD
		cd ../..
		HASH=$(git -C "cache/${COMMIT}" rev-parse --verify --quiet HEAD)
		if [ "${COMMIT}" != "${HASH}" ]; then
			echo "Invalid hash ${HASH} (expected ${COMMIT})."
			rm -rf "cache/${COMMIT}"
			exit 1
		fi
		rm -R "cache/${COMMIT}/.git"
	fi
	mkdir -p "build/chroot/${DESTDIR}"
	cp -aR "cache/${COMMIT}/." "build/chroot/${DESTDIR}"
}

rm -rf build
mkdir -p build/chroot cache
echo "Retrieving sources..."
source git-repos.sh
echo "Retrieving sources done."
