#!/bin/bash
focused_output=$(bspc query --monitors -m focused --names)
if [ "$focused_output" = "eDP1" ]; then
    font="Iosevka 12"
else
    font="Iosevka 15"
fi
