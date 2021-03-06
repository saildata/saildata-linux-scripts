#!/bin/sh

# Usage: get-file-usage-of-type [valid file extension]

if [ -n "$1" ]; then
	find . -iname "*.$1" -print0 | du --files0-from - -c -s -h | tail -1
else
	printf "Error: No filetype provided.\n"; exit 1
fi
