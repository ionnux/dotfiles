#!/bin/bash

while getopts :a:s:m:n opt
do

    volume=$(pactl list sinks | grep -m1 Volume | awk -F '/' '{print $2}' | tr -d ' ' | tr -d '%')
    case "${opt}" in
        a) if [[ $volume -gt 150 ]]
            then
                volume=150
            else
                volume=$((volume + OPTARG))
            fi
            ;;

        s) if [[ $volume -gt 0 ]]; then
                volume=$((volume - OPTARG))
            fi
            ;;

        m) pactl set-sink-mute @DEFAULT_SINK@ toggle ;;

        n) notify='on' ;;

    esac

    pactl set-sink-volume @DEFAULT_SINK@ ${volume}%
    mute=$(pactl list sinks | grep Mute | awk -F ' ' '{print $2}')

    if [[ $volume == 0 || "$mute" == "yes" ]]; then
        volume_icon="audio-volume-muted-symbolic"
    else
        if [ $volume -lt 30 ]; then
            volume_icon="audio-volume-low-symbolic"
        elif [ $volume -lt 70 ]; then
            volume_icon="audio-volume-medium-symbolic"
        elif [ $volume -le 100 ]; then
            volume_icon="audio-volume-high-symbolic"
        else
            volume_icon="audio-volume-overamplified-symbolic"
        fi
    fi

    if [[ $notify == "on" ]]; then
        dunstify -h string:x-dunst-stack-tag:control "Volume" -h int:value:"$volume" -t 1500 --icon "$volume_icon"
    fi
done

