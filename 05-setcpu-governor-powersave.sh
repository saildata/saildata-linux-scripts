#!/usr/bin/bash

# Set the CPU govenor to performance

cpupower frequency-set -g 'powersave' && cpupower frequency-info --policy
