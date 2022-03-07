#!/bin/bash

while getopts :a:s:n opt
do

    brightness=$(xbacklight -get | tr '\.' '\n' | grep -m1 .)
    case "${opt}" in
        a)
            if [[ $brightness -lt 100 ]]; then
                xbacklight -time 0 -steps 1 -inc $OPTARG
            fi
            ;;
        s)
            if [[ $brightness -gt 0 ]]; then
                xbacklight -time 0  -steps 1 -dec $OPTARG
            fi
            ;;
        n)  notify="on" ;;
    esac

    if [[ $notify == "on" ]]; then

        brightness=$(xbacklight -get | tr '\.' '\n' | grep -m1 .)
        if [ $brightness -eq 0 ]; then
            dunstify -h string:x-canonical-private-synchronous:control "Brightness:" -h int:value:"$brightness" -t 1500 --icon display-brightness-off-symbolic
        elif [ $brightness -le 30 ]; then
            dunstify -h string:x-canonical-private-synchronous:control "Brightness:" -h int:value:"$brightness" -t 1500 --icon display-brightness-low-symbolic
        elif [ $brightness -le 70 ]; then
            dunstify -h string:x-canonical-private-synchronous:control "Brightness:" -h int:value:"$brightness" -t 1500 --icon display-brightness-medium-symbolic
        else
            dunstify -h string:x-canonical-private-synchronous:control "Brightness:" -h int:value:"$brightness" -t 1500 --icon display-brightness-high-symbolic
        fi

    fi
done
