#!/bin/sh
#
# Quick/hot swap between more/less strict Firefox profiles
# 
# Setup: Export the following two globals from bashrc file
# FF_TARGET    points to your actual user.js file within .mozilla dir 
# USER_JS_BASE points to a dir with two foldrs (ff-on and ff-off) that each
#              have a user.js file that is hot-swapped into the FF_TARGET dir
# Usage: call userdotjs script while FF is not running, restart FF

ON_OFF=on

echo "More or less, sir?" 1>&2
read PROFILE

if [ $PROFILE ]; then
if [ $PROFILE = 'more' -o $PROFILE = '1' ]; then
    echo "Got it, more."
	cp -i $USER_JS_BASE/ff-$ON_OFF/user.js $FF_TARGET
else
	ON_OFF=off
    echo "Got it, less"
	cp -i $USER_JS_BASE/ff-$ON_OFF/user.js $FF_TARGET
fi
fi
