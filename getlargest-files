#!/bin/sh
# Get largest files in current path/tree

FilesbySize() {
    echo "${white}Top 10 items by file size${reset}" >&2
    
    find . -type f -print0 | xargs -0 du | sort -nr | uniq | head -10 | cut -f2 | xargs -I{} du -sh {} 

    echo ""
}

FilesbySize
