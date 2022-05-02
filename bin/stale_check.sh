#!/usr/bin/env bash

# This script will check the HLS folder to look for anything fishy.  If the
# folder size is unusually large or the files have not been updated in several
# minutes, the encode process will be restarted

function run() {


size=$( du /tmp/$1/ | gawk '{ print $1 }' )

modtime=$( stat -c %Y /tmp/$1 )
nowtime=$( date +%s )
deltatime=$(( $nowtime - $modtime ))


if [ "$size" -gt 10000 ]
then
    echo "$1 folder is too big: $size"
    return 1
fi


if [ "$deltatime" -gt 60 ]
then
    echo "$1 folder is too old: $deltatime seconds"
    return 2
fi

return 0

}

function reset() {

	echo "Reset!"
	systemctl restart scam_hls.service
	systemctl restart scam_hls2.service

}

while true
do
	sleep 300
    echo "Sanity Check of HLS folders"
	run KitchenCam && run LivingRoomCam || reset
done

