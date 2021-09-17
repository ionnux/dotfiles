#!/bin/bash

while getopts :a:s:n opt
do

    volume=$(pactl list sinks | tr ' ' '\n' | grep -m1 '%' | tr -d '%')
    case "${opt}" in
        a)
            if [[ $volume -lt 100 ]]; then
                pactl set-sink-volume @DEFAULT_SINK@ +$OPTARG%
                volume=$(pactl list sinks | tr ' ' '\n' | grep -m1 '%' | tr -d '%')

                if [[ $volume -gt 100 ]]; then
                    pactl set-sink-volume @DEFAULT_SINK@ 100%
                    volume=$(pactl list sinks | tr ' ' '\n' | grep -m1 '%' | tr -d '%')
                fi

            fi

            ;;
        s)
            if [[ $volume -gt 0 ]]; then
                pactl set-sink-volume @DEFAULT_SINK@ -$OPTARG%
                volume=$(pactl list sinks | tr ' ' '\n' | grep -m1 '%' | tr -d '%')
            fi

            ;;
        n)  notify="on" ;;
    esac

    if [[ $notify == "on" ]]; then
        dunstify "VOLUME: " -h int:value:$volume
    fi
done

