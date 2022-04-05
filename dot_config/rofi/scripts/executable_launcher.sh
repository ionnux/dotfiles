#!/bin/bash

focused_output=$(bspc query --monitors -m focused --names)
if [ "$focused_output" = "eDP1" ]; then
    font="Iosevka 13"
else
    font="Iosevka 16"
fi

rofi -show drun -display-drun launcher -config ~/.config/rofi/dmenu.rasi -theme-str "configuration {font: \"$font\";}"

