#!/bin/bash
#
# Changes the current background
#     example: setbackground.sh /home/tux/Pictures/awesome_picture.png

gsettings set org.gnome.desktop.background picture-uri "$(readlink -f "$1")"

