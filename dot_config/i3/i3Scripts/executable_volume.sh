#!/bin/bash

while getopts :a:s:n opt
do

    volume=$(pactl list sinks | tr ' ' '\n' | grep -m1 '%' | tr -d '%')
    case "${opt}" in
        a)
            if [[ $volume -ge 100 ]]
            then
                pactl set-sink-volume @DEFAULT_SINK@ 100%
            else
                pactl set-sink-volume @DEFAULT_SINK@ +$OPTARG%
            fi
            ;;

        s)
            if [[ $volume -gt 0 ]]; then
                pactl set-sink-volume @DEFAULT_SINK@ -$OPTARG%
            fi
            ;;

        n) notify='on' ;;
    esac

    volume=$(pactl list sinks | tr ' ' '\n' | grep -m1 '%' | tr -d '%')
    if [[ $notify == "on" ]]; then
        if [ $volume -le 30 ]; then
            dunstify -h string:x-canonical-private-synchronous:audio "Volume: " -h int:value:"$volume" -t 1500 --icon audio-volume-low
        elif [ $volume -le 70 ]; then
            dunstify -h string:x-canonical-private-synchronous:audio "Volume: " -h int:value:"$volume" -t 1500 --icon audio-volume-medium
        else
            dunstify -h string:x-canonical-private-synchronous:audio "Volume: " -h int:value:"$volume" -t 1500 --icon audio-volume-high
        fi

    fi
done

