#!/usr/bin/env bash

# This script will check the HLS folder to look for anything fishy.  If the
# folder size is unusually large or the files have not been updated in several
# minutes, the encode process will be restarted

function run() {

echo "Checking the $1 folder"

size=$( du /tmp/$1/ | gawk '{ print $1 }' )
echo "Folder size: $size"

modtime=$( stat -c %Y /tmp/$1 )
nowtime=$( date +%s )
deltatime=$(( $nowtime - $modtime ))

echo "Last Modified $deltatime seconds ago"

if [ "$size" -gt 10000 ]
then
    return 1
fi


if [ "$deltatime" -gt 60 ]
then
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
	run KitchenCam && run LivingRoomCam || reset
done

