#!/bin/bash

mute=$(pactl list sinks | grep Mute | awk -F ' ' '{print $2}')
volume=$(amixer -D pulse sget Master | grep -E -o -m1 "[[:digit:]]+%" | tr -d '%')

if [[ $volume == 0 || "$mute" == "yes" ]]; then
    volume_icon="audio-volume-muted-symbolic"
else
    if [ $volume -lt 30 ]; then
        volume_icon="audio-volume-low-symbolic"
    elif [ $volume -lt 70 ]; then
        volume_icon="audio-volume-medium-symbolic"
    elif [ $volume -le 100 ]; then
        volume_icon="audio-volume-high-symbolic"
    fi
fi

dunstify -h string:x-dunst-stack-tag:control  -i "$volume_icon" -h int:value:"$volume" "volume: ${volume}%"

