#!/bin/bash
#
# Returns the current background picture file location

gsettings get org.gnome.desktop.background picture-uri | sed --expression='s|file://||g' | tr -d "'" 2>/dev/null

# | xargs xdg-open



