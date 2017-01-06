#!/bin/sh

# Because Java is real.
sync; sync; sync;
sudo sh -c "sync; echo 3 > /proc/sys/vm/drop_caches"
