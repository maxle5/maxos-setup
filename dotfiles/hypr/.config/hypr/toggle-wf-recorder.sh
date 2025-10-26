#!/bin/env bash

RECORDING_FLAG="/tmp/waybar-recording.flag"
pgrep -x "wf-recorder" && pkill -INT -x wf-recorder && notify-send -h string:wf-recorder:record -t 1000 "Finished Recording" && rm -f "$RECORDING_FLAG" && exit 0

dateTime=$(date +%m-%d-%Y-%H:%M:%S)
touch "$RECORDING_FLAG"
wf-recorder -F fps=30 -g "$(slurp)" -f $HOME/Videos/Captures/$dateTime.mp4
