#!/bin/sh
#
# Start dropbox | sync | quit
# Why? Bc it doesn't need to run 24/7. 
# TODO: Quit being lazy and setup OwnCloud.

# ignore if dropbox is already running

if pidof -x "dropbox" >/dev/null; then
    echo "Err 2: dropbox is already running." 
    exit 2
else
    ( dropbox start & ) >/dev/null &
    sleep 1
fi

# wait for sync to finish, then quit
while true; do
    if [ $(dropbox status) = 'Up to date' ]; then
        dropbox stop &>/dev/null && exit 0        
    else
        sleep 2 &
    fi
done
