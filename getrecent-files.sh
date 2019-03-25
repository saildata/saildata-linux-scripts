#!/bin/sh
#
# Get list of most recent files in current path. Useful for "Where did that go? I just saved it..."

echo "Minutes to search? (Default=5)" 1>&2
read MINUTES

if [ $MINUTES ]; then
	find . -readable -cmin -$MINUTES
else
	MINUTES=5
	find . -readable -cmin -$MINUTES
fi

