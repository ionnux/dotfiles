#!/bin/bash

while getopts :a:s:n opt
do

    brightness=$(xbacklight -get | tr '\.' '\n' | grep -m1 .)
    case "${opt}" in
        a)
            if [[ $brightness -lt 100 ]]; then
                xbacklight -time 30 -steps 1 -inc $OPTARG
            fi
            ;;
        s)
            if [[ $brightness -gt 0 ]]; then
                xbacklight -time 30  -steps 1 -dec $OPTARG
            fi
            ;;
        n)  notify="on" ;;
    esac

    if [[ $notify == "on" ]]; then
        brightness=$(xbacklight -get)
        echo $brightness
        dunstify "BRIGHTNESS: " -h int:value:$brightness

    fi
done
