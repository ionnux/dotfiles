#!/bin/bash

while getopts :a:s:n opt
do

    brightness=$(xbacklight -get | awk -F '.' '{print $1}')
    case "${opt}" in
        a) brightness=$((brightness + OPTARG)) ;;
        s) brightness=$((brightness - OPTARG)) ;;
        n)  notify="on" ;;
    esac

    xbacklight -time 0  -steps 1 -set $brightness

    if [ $brightness -lt 30 ]; then
        brightness_icon="display-brightness-low-symbolic"
    elif [ $brightness -lt 60 ]; then
        brightness_icon="display-brightness-medium-symbolic"
    else
        brightness_icon="display-brightness-high-symbolic"
    fi

    if [[ $notify == "on" ]]; then
        dunstify -h string:x-dunst-stack-tag:control "Brightness" -h int:value:"$brightness" --icon "$brightness_icon"
    fi
done
