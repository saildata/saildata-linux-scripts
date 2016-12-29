#!/bin/sh

# Dim laptop backlight if between 8pm and 7am
# Usage: startup events
# Notes: doesn't seem to work with Nvidia (GeForce GTX 965M)

hour_now=`date +%H`

if [ $hour_now -ge 20 ] || [ $hour_now -le 7 ]; then
  xbacklight -set 4
fi
