#!/bin/sh
# Remove broken links in the current directory
# See also: find-dead-links

find . -type l -exec sh -c 'for x; do [ -e "$x" ] || rm "$x"; done' _ {} +
