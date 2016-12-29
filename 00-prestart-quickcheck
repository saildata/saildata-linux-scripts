#!/usr/bin/bash

set -euo pipefail
IFS=$'\n\t'

# Quick check on boot time and any failed modules using systemctl (system and user)
#
# Usage: 00-prestart-quickcheck

GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
RED=$(tput setaf 1)
NORMAL=$(tput sgr0)

INIT_START_TIME=0
_KERNEL_START_TIME=0
KERNEL_START_TIME=0
USER_START_TIME=0

# Test if we have seconds or (default) ms
function test_user_time_unit {
    local unit_is_ms _USER_START_TIME
    unit_is_ms=$(systemd-analyze | cut -d' ' -f13 | grep 'ms')
    _USER_START_TIME="$(systemd-analyze | cut -d' ' -f13 | egrep --color=never -o '[0-9]+\.?[0-9]*')"

    # If the units are not ms (then seconds) and scale the result
    if [ -z "$unit_is_ms" ]
    then USER_START_TIME=$(bc <<< "scale=3; $_USER_START_TIME * 1000")
    else USER_START_TIME="$_USER_START_TIME"
    fi
}
test_user_time_unit

INIT_START_TIME="$(systemd-analyze | cut -d' ' -f7 | egrep --color=never -o '[0-9]+\.?[0-9]*')"
_KERNEL_START_TIME="$(systemd-analyze | cut -d' ' -f10 | egrep --color=never -o '[0-9]+\.?[0-9]*')"

KERNEL_START_TIME=$(bc <<< "scale=3; $_KERNEL_START_TIME * 1000")

_TOTALTIME=$(bc <<< "scale=3; $KERNEL_START_TIME + $INIT_START_TIME + $USER_START_TIME")
TOTALTIME=$(bc <<< "scale=3; $_TOTALTIME / 1000")

function main {
    # systemctl checks for system and user
    systemctl --failed | \
        test "$(grep -c "0 loaded units listed")" = 1 && echo -e "${GREEN}(SYSTEM) Systemctl OK${NORMAL}" || \
        echo -e "${RED}Check systemctl${NORMAL}"
    systemctl --failed --user | \
        test "$(grep -c "0 loaded units listed")" = 1 && echo -e "${GREEN}(USER) Systemctl OK${NORMAL}" || \
        echo -e "${RED}Check systemctl (user)${NORMAL}"
    # boot time in seconds
    echo -e "Init + Kernel + Userspace: ${BLUE}$TOTALTIME seconds${NORMAL}"
}
main
