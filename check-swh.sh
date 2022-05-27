#!/bin/bash -e

function repo() {
	URL=$3
	COMMIT=$5
	SWHID="swh:1:rev:$COMMIT"
	[ -v urls[$SWHID] ] && return
	ids+=("$SWHID")
	urls["$SWHID"]="$URL"
}

function swhresult() {
	if [ "$2" == "false" ]; then
		missing+=("$1")
	else
		found+=("$1")
	fi
}

ids=()
found=()
missing=()
declare -A urls=()

source git-repos.sh

POSTDATA=$((for id in "${ids[@]}"; do echo $id; done) | jq -s -R '[split("\n")|.[]|select(length > 0)]')

source <(curl -X POST -H "Content-Type: application/json" \
	-d "$POSTDATA" 'https://archive.softwareheritage.org/api/1/known/' | \
	jq -r 'to_entries[] | [ "swhresult", .key, .value.known] | @sh ')

echo
echo "Found: ${#found[@]} SWH IDs"
for id in "${found[@]}"; do
	echo "   $id from ${urls[$id]}"
done

echo
echo "Missing: ${#missing[@]} SWH IDs"
for id in "${missing[@]}"; do
	echo "   $id from ${urls[$id]}"
done

test "${#missing[@]}" == "0" -a "${#found[@]}" == "${#ids[@]}"
