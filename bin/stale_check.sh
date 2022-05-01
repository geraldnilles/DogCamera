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

if [ "$size" -lt 10000 ]
then
    if [ "$deltatime" -lt 60 ]
    then
        return
    fi
fi

echo "Restart HLS Services"

}

run LivingRoomCam
run KitchenCam

