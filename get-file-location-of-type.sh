#!/bin/sh

# Usage: get-file-location-of-type [valid file extension]

if [ -n "$1" ]; then
	printf "%s\n" | xargs find . -iname  "*.$1"
else
	printf "Error: No filetype provided.\n"; exit 1
fi

