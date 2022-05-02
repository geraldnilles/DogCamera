#!/usr/bin/env bash

# This script will check the HLS folder to look for anything fishy.  If the
# folder size is unusually large or the files have not been updated in several
# minutes, the encode process will be restarted

# TODO Dynamically detect how many HLS services are running
#   systemctl --full --all --plain --no-legend list-units scam_hls*

for name in $( systemctl --full --all --plain --no-legend list-units scam_hls* | sed 's/scam_hls@\(\S*\).service.*/\1/' )
do


    size=$( du /tmp/$name/ | gawk '{ print $1 }' )

    modtime=$( stat -c %Y /tmp/$name )
    nowtime=$( date +%s )
    deltatime=$(( $nowtime - $modtime ))



    if [ "$size" -gt 10000 ]
    then
        echo "$name folder is too big: $size"
        systemctl restart scam_hls@$name.service
    fi


    if [ "$deltatime" -gt 60 ]
    then
        echo "$name folder is too old: $deltatime seconds"
        systemctl restart scam_hls@$name.service
    fi


done

