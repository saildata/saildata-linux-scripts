#!/bin/sh

# Decrease 'Device Accel Constant Deceleration'
# e.g. make the mouse more reactive
# Setup: 
# Find device info: xinput (find device, <n>); 
#                   xinput list-inputs <n>
# Usage: xinput set-prop <n> <property-id> <value>
set -e

DEV_N=$( xinput | grep -i logitech | cut --f=2 | cut --d='=' --f=2 )

DEV_N_ATTR=$( xinput list-props 10 | grep 'Device Accel Constant Deceleration' | awk '{ print $5 }' | tr -d '(): ' )

xinput set-prop $DEV_N $DEV_N_ATTR 0.70
