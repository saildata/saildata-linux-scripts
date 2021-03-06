#!/bin/sh

# Adjust for a 4k second monitor (with primary display off)
#
# Usage: setmonitor-resolution-4k


set -e

nvidia-settings --assign "CurrentMetaMode = DPY-4: nvidia-auto-select @3840x2160 +0+0 {ViewPortIn=3840x2160, ViewPortOut=3840x2160+0+0}" &>/dev/null
