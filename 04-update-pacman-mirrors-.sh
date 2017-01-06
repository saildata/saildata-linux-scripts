#!/usr/bin/bash
# Usage:
#           04-update-pacaman-mirrors
#
# DESC: Lazy wrapper around reflector mirror service

SUDO=''

# Test the effective user id & prompt for sudo
if (( $(id -u) != 0 )); then
    SUDO='sudo'
fi

function mirror-update(){
    "$SUDO" systemctl reload-or-restart reflector.service
}

mirror-update
