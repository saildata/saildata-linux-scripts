#!/usr/bin/bash

# Swap display to a 4k monitor, turn off output to main display

# Usage: setmonitor-resolution-4k

set -e

function main() {
  nvidia-settings --assign "CurrentMetaMode = DPY-4: nvidia-auto-select @3840x2160 +0+0 {ViewPortIn=3840x2160, ViewPortOut=3840x2160+0+0}" >& /dev/null
}
main
