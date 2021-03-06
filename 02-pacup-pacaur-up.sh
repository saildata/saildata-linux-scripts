#!/usr/bin/bash
# Usage:
#           02-pacup-pacaur-up
#
# DESC: Lazy wrapper around software updates

SUDO=''

# Test the effective user id & prompt for sudo
if (( $(id -u) != 0 )); then
    SUDO='sudo'
fi

function pacaur-up(){
    pacaur -yku && echo ''
}

function pacup(){
    "$SUDO" pacman -Syyu
}

function repo_update() {
    sudo -k \
    && pacup \
    && sudo -k \
    && pacaur-up \
    && sudo -k
}
repo_update
