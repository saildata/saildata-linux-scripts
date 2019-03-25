#!/bin/sh

# Prettyprint dmesg using ccze program - makes it much easier to read the dmesg output 
dmesg -T -l 1,2,3,4 | ccze -p syslog -A
