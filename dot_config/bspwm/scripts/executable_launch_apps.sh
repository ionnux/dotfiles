#!/bin/bash

kitty=~/.local/kitty.app/bin/kitty
split="no"
focused_output=$(bspc query --monitors -m focused --names)
# windows=$(xdotool search --desktop $(xdotool get_desktop) --name "scratchpad_" getwindowname %@)
windows=$(xdotool search --desktop $(xdotool get_desktop) --name "scratchpad_")
display_primary_x=1920
display_primary_y=1080
display_other_x=1920
display_other_y=1200
display_primary_start_position=0
display_other_start_position=1920

if [ "$focused_output" = "eDP1" ]; then
    start_position=$display_primary_start_position
    width=$(( display_primary_x - 4 ))
    height=950
    x=$((  start_position + 0 ))
    y=0
    font=14
else
    start_position=$display_other_start_position
    width=$(( display_other_x - 6 ))
    height=1878
    x=$((  start_position + 0 ))
    y=0
    font=18
fi

# hide_except () {
#     while read -r window; do
#         if [[ "$window" != "$1" ]]; then
#             xdo hide -a "$window"
#         fi
#     done <<< "$windows"
# }
hide_except () {
    while read -r window_id; do
        if [[ "$window_id" != "$1" ]]; then
        bspc node "$window_id" --flag hidden=on -f
        fi
    done <<< "$windows"
}

# launch() {
#     if [[ "$split" == "no" ]]; then
#         hide_except "$1"
#     fi

#     id=$(xdo id -a "$1");
#     if [ -z "$id" ]; then
#         bspc rule -a kitty:kitty:$1 sticky=on state=floating rectangle=${width}x${height}+${x}+${y}
#         eval "$2"
#     else
#         action='hide';
#         if [[ $(xprop -id $id | awk '/window state: / {print $3}') == 'Withdrawn' ]]; then
#             action='show';
#         fi
#         bspc rule -a kitty:kitty:$1 sticky=on state=floating rectangle=${width}x${height}+${x}+${y}
#         xdo $action -a "$1"

#         # x_position=$(bspc query --tree --node $(xdotool search --name $1) | jq ' .client.floatingRectangle.x')
#         # if [[ "$focused_output" != "eDP1" ]] && [[ "$x_position" != "" ]]; then
#         #     if [[ "$x_position" -le "1920" ]]; then
#         #         xdo hide -a "$1"
#         #         xdo show -a "$1"
#         #     else
#         #         xdo $action -a "$1"
#         #     fi
#         # else
#         #     if [[ "$x_position" -ge "1920" ]]; then
#         #         xdo hide -a "$1"
#         #         xdo show -a "$1"
#         #     else
#         #         xdo $action -a "$1"
#         #     fi
#         # fi

#     fi
#     sleep 0.4
#     $kitty @ --to unix:@"$1" set-font-size $font

# }

launch() {
    id=$(xdotool search --name $1)

    if [[ "$split" == "no" ]]; then
        hide_except "$id"
    fi

    if [ -z "$id" ]; then
        bspc rule -a kitty:kitty:$1 sticky=on state=floating rectangle=${width}x${height}+${x}+${y}
        eval "$2"
    else
        bspc node "$id" --flag hidden --focus
    fi
    sleep 0.4
    $kitty @ --to unix:@"$1" set-font-size $font

}

case "$1" in
    "scratchpad_terminal1") launch "$1" '$kitty --listen-on=unix:@"$1" --title  "$1" &' ;;
    "scratchpad_terminal2") launch "$1" '$kitty --listen-on=unix:@"$1" --title  "$1" &' ;;
    "scratchpad_ncmpcpp") launch "$1" '$kitty --listen-on=unix:@"$1" --title "$1" ~/.config/ncmpcpp/ncmpcpp-ueberzug/ncmpcpp-ueberzug &' ;;
    "scratchpad_vifm")launch "$1" '$kitty --listen-on=unix:@scratchpad_vifm --title scratchpad_vifm env TERM=kitty-direct ~/.config/vifm/scripts/vifmrun ~ &' ;;

    "scratchpad_fullterm")
        $kitty --listen-on=unix:/tmp/kitty_remote --title scratchpad_fullterm &
        disown
        move_to_scratchpad_except "scratchpad_fullterm"
        sleep 0.2
        ~/.config/i3/i3Scripts/change_display_properties.sh
        ;;

    "scratchpad_scrcpy")
        if ! pgrep -a scrcpy | grep scratchpad_scrcpy; then
            scrcpy --window-title 'scratchpad_scrcpy' --tcpip -Sw &
        fi

        if [[ "$split" == "no" ]]; then
            move_to_scratchpad_except "scratchpad_scrcpy"
        fi
        scratchpad_show "scratchpad_scrcpy"
        ~/.config/i3/i3Scripts/change_display_properties.sh
        ;;
esac
