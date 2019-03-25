#!/bin/bash

# Set the CPU govenor to performance

cpupower frequency-set -g 'performance' && cpupower frequency-info --policy
