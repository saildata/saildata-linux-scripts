#!/bin/sh

# Start xflux daemon on Linux (crontab)
# Note: FLUXZ_DAY_LAT, FLUXZ_DAY_LON, and FLUXZ (actual zip code) are in global scope (export from bash_profile).
#       Day is arbitrarily selected at a position approximately on the other side of the world, since xflux seems
#       to only work in `night' mode...

hour_now=`date +%H`

# set default kcode for incremental 2 hour blocks during evening hours
if [ "$hour_now" -ge 18 ] && [ "$hour_now" -le 20 ]; then
    kcode=3950
elif [ "$hour_now" -ge 20 ] && [ "$hour_now" -le 22 ]; then
    kcode=3800
elif [ "$hour_now" -ge 20 ] && [ "$hour_now" -le 22 ]; then
    kcode=3650
elif [ "$hour_now" -ge 22 ] && [ "$hour_now" -le 24 ]; then
    kcode=3500
elif [ "$hour_now" -le 6 ]; then
    kcode=3300
else
    kcode=4000
fi

# allow user to set kcode from command line
while getopts k: opt; do
  case $opt in
    k)
      kcode="$OPTARG" ;
      ;;
    \?)
      echo "Err 1: Invalid option: -$OPTARG" &>/dev/null
      exit 1
      ;;
  esac
done

# restart xflux if needed
if pidof -x "xflux" &>/dev/null; then
    killall xflux
fi

# start xflux
if [ "$hour_now" -ge 18 ] || [ "$hour_now" -le 6 ]; then
	xflux -z "$FLUXZ" -k "$kcode"
  	echo -e "Starting xflux in Night mode (k = "$kcode")" &>/dev/null
else
	xflux -l "$FLUXZ_DAY_LAT" -g "$FLUXZ_DAY_LON" -k "$kcode"
	echo -e "Starting xflux in Day mode (k = "$kcode")" &>/dev/null
fi
