#!/bin/bash

kitty=~/.local/kitty.app/bin/kitty
focused_output=$(bspc query --monitors -m focused --names)
windows=$(xdotool search --desktop $(xdotool get_desktop) --name auto getwindowname %@)

display_primary_x=1920
display_primary_y=1080
display_other_x=1200
display_other_y=1920
display_primary_start_position=0
display_other_start_position=1920

if [[ "$focused_output" == "eDP1" ]]; then
    start_position=$display_primary_start_position
    width=$(( display_primary_x - 6 ))
    height=950
    x=$((  start_position + 2 ))
    y=0
    font=14
else
    start_position=$display_other_start_position
    width=$(( display_other_x - 6 ))
    height=1800
    x=$((  start_position + 1 ))
    y=0
    font=18
fi

change_all_size_and_position_and_fontsize() {
    while read -r window; do
        $kitty @ --to unix:@"$window" set-font-size $font
        xdo resize -w $width -h $height -a "$window"
        xdo move -x $x -y $y -a "$window"
    done <<< "$windows"
}

change_all_size_and_position_and_fontsize
