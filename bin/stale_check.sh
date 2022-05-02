#!/usr/bin/env bash

# This script will check the HLS folder to look for anything fishy.  If the
# folder size is unusually large or the files have not been updated in several
# minutes, the encode process will be restarted

# TODO Dynamically detect how many HLS services are running
#   systemctl --full --all --plain --no-legend list-units scam_hls*

function run() {


size=$( du /tmp/$1/ | gawk '{ print $1 }' )

modtime=$( stat -c %Y /tmp/$1 )
nowtime=$( date +%s )
deltatime=$(( $nowtime - $modtime ))


if [ "$size" -gt 10000 ]
then
    echo "$1 folder is too big: $size"
	systemctl restart scam_hls@$1.service
    return 1
fi


if [ "$deltatime" -gt 60 ]
then
    echo "$1 folder is too old: $deltatime seconds"
	systemctl restart scam_hls@$1.service
    return 2
fi

return 0

}

while true
do
	sleep 300
    echo "Sanity Check of HLS folders"
	run KitchenCam
    run LivingRoomCam
done

