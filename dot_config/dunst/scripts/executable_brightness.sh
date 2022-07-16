#!/bin/bash

brightness=$(xbacklight -get | awk -F '.' '{print $1}')

if [ $brightness -lt 30 ]; then
    brightness_icon="display-brightness-low-symbolic"
elif [ $brightness -lt 60 ]; then
    brightness_icon="display-brightness-medium-symbolic"
else
    brightness_icon="display-brightness-high-symbolic"
fi

# dunstify -h string:x-dunst-stack-tag:control "Brightness" -h int:value:"$brightness" --icon "$brightness_icon"
dunstify -h string:x-dunst-stack-tag:control  -i "$brightness_icon" -h int:value:"$brightness" "brightness: ${brightness}%"

