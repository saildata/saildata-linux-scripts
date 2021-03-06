#!/bin/sh

# Make sure we're not running wifi when ethernet is up (other methods have failed and the radio stays on...)
# 
# Note: Set to run at boot.

eth_stat=$(cat /sys/class/net/eth0/operstate)

if [ $eth_stat = "up" ]; then
    rfkill block wifi
    exit 0
fi
