#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Auto run startup script to set the keyboard rate using xset (X11)
#
# Optional input args used for various app (or personal!) quirks
# as a standalone script
#
# Usage 07-correct-keyboard-repeat [-h] [-d <delay>] [-r <rate>]

DELAY=255
RATE=30

show_usage(){
cat << EOF
  Usage: "$(basename "$0")": [-h] [-d <delay>] [-r <rate>]

      [Default values]
          Delay - 255
          Rate  - 30

  Output can be verified using 'xset q'.

EOF
}

main(){
    xset r rate "$DELAY" "$RATE"
}

while getopts ":hd:r:" opt; do
    case $opt in
        h)
            show_usage
            exit
            ;;
        d)
            DELAY=$OPTARG
            ;;
        r)
            RATE=$OPTARG
            ;;
        \?)
            echo "invalid option -$OPTARG" >&2
            ;;
    esac
done

main
