#!/usr/bin/env bash

# This will start the HLS transcoding process
# Rather than run this in node.js.  i will let systemd be in charge of starting
# and stopping it

DIRECTORY=/tmp/$1

rm -rf $DIRECTORY
mkdir -p $DIRECTORY

# TODO Attempt to reset the camera via HTTP command
# https://10.0.0.132/cgi-bin/action.cgi?cmd=reboot

# TODO Look for large folder size and restart if it gets out of hand

cd $DIRECTORY

/mnt/raid/Code/Media-Center-2.0/On-Demand-Transcoder/ffmpeg \
    -y \
    -loglevel error \
    -i rtsp://$1:8554/unicast \
    -timeout 10 \
    -stimeout 10000000 \
    -c:v copy \
    -f hls \
    -hls_time 2 \
    -hls_list_size 3 \
    -hls_flags delete_segments \
    -use_localtime 1 \
    -hls_segment_filename "out-%Y%m%d-%s.ts" \
    out.m3u8

# If ffmpeg ever fails, wait 30s before you retry
echo "ffmpeg stopped.  Waiting 30 seconds before attempting to restart"
sleep 30

