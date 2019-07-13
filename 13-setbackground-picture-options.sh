#!/bin/bash
#
# Change how the background is displayed (default is 'zoom')
# Possible values are “none”, “wallpaper”, “centered”, “scaled”, “stretched”, “zoom”, “spanned”.

if [[ -n "$1" ]]
# If argv[1] is not empty
then
    gsettings set org.gnome.desktop.background picture-options "$1"
else
    gsettings set org.gnome.desktop.background picture-options 'zoom'
fi
