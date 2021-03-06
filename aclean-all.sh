#!/usr/bin/bash
# Usage:
#           aclean-all
#
# Remove (potentially large) archive files in current directory
# Specific use case - AUR cache

find -type f \( -name '*.7z' -or \
    -name '*.bz2' -or \
    -name '*.deb' -or \
    -name '*.gz' -or \
    -name '*.tar.gz' -or \
    -name '*.xz' -or \
    -name '*.zip' \) \
    -exec rm -i {} \;
