#!/bin/bash

kitty=~/.local/kitty.app/bin/kitty
split="no"
focused_output=$(bspc query --monitors -m focused --names)
# windows_in_focused_monitor=$(xdotool search --desktop $(xdotool get_desktop) --name "")
display_primary_x=1920
display_primary_y=1080
display_other_x=1920
display_other_y=1200
display_primary_start_position=0
display_other_start_position=1920

if [ "$focused_output" = "eDP1" ]; then
    display_x=1920
    display_y=1080
    start_position=$display_primary_start_position
    width=$display_primary_x
    height=950
    x=$start_position
    y=0
    font_size=14
    vivaldi_height=1000
else
    display_x=1920
    display_y=1200
    start_position=$display_other_start_position
    width=$(( display_other_x - 6 ))
    height=1878
    x=$((  start_position + 0 ))
    y=0
    font_size=18
fi

declare -A scratchpad_window_array=(
    [scratchpad_terminal1]="name scratchpad_terminal1"
    [scratchpad_terminal2]="name scratchpad_terminal2"
    [scratchpad_ncmpcpp]="name scratchpad_ncmpcpp"
    [scratchpad_vifm]="name scratchpad_vifm"
    [scratchpad_btop]="name scratchpad_btop"
    [scratchpad_lazygit]="name scratchpad_lazygit"
    # [scratchpad_vivaldi]="class Vivaldi-stable"
)


hide_all_windows_except () {
    for window_array_key in ${!scratchpad_window_array[@]}; do
        local window_array_value="${scratchpad_window_array[$window_array_key]}"

        # if [[ $window_array_key == "scratchpad_btop" ]]; then
        #     if [[ ! -z $(xdotool search --desktop $(xdotool get_desktop) --name $window_array_key getwindowname %@) ]]; then
        #         pkill -f scratchpad_btop
        #     fi
        # else
        local scratchpad_window_id=$(eval 'xdotool search --desktop $(xdotool get_desktop) --$window_array_value')

        if [[ ! -z $scratchpad_window_id && $scratchpad_window_id != $1 ]]; then
            bspc node "$scratchpad_window_id" --flag hidden=on
        fi

        # fi
    done
}


# launch() {
#     if [[ "$split" == "no" ]]; then
#         hide_all_windows_except "$1"
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
#     $kitty @ --to unix:@"$1" set-font-size $font_size

# }

toggle_scratchpad() {
    local id=$(eval 'xdotool search --$2 $3')

    if [[ "$split" == "no" ]]; then
        # if [[ $1 != scratchpad_btop ]]; then
        hide_all_windows_except "$id"
        # fi
    fi

    if [ -z "$id" ]; then
        if [[ $1 =~ scratchpad_(terminal1|terminal2|vifm|btop|lazygit) ]]; then
            bspc rule -a kitty:kitty:$3 sticky=on state=floating rectangle=$(( width - 4 - 40 ))x${height}+$(( x + 20 ))+$(( y + 20 ))
        elif [[ $1 == scratchpad_ncmpcpp ]]; then
            bspc rule -a kitty:kitty:$3 sticky=on state=floating rectangle=$(( 700 ))x$(( 300 ))+$(( (display_x - 700 - 8)/2 ))+$(( 30 ))
        fi

        eval "$4"
    else
        bspc node "$id" --flag hidden --focus
    fi

    # if [[ $1 =~ scratchpad_(terminal1|terminal2|vifm|ncmpcpp) ]]; then
    #     sleep 0.4
    #     $kitty @ --to unix:@"$3" set-font-size $font_size
    # fi

}

case "$1" in
        # toggle_scratchpad [identifier][name|class][actual name|class][launch command]
    "scratchpad_terminal1") toggle_scratchpad "$1" "name" "$1" "$kitty --listen-on=unix:@"$1" --title  "$1" &" ;;
    "scratchpad_terminal2") toggle_scratchpad "$1" "name" "$1" "$kitty --listen-on=unix:@"$1" --title  "$1" &" ;;
    "scratchpad_ncmpcpp") toggle_scratchpad "$1" "name" "$1" "$kitty --listen-on=unix:@"$1" --title "$1" ~/.config/ncmpcpp/ncmpcpp-ueberzug/ncmpcpp-ueberzug &" ;;
        # "scratchpad_ncmpcpp") toggle_scratchpad "$1" "name" "$1" "$kitty --listen-on=unix:@"$1" --title "$1" ncmpcpp &" ;;
    "scratchpad_vifm") toggle_scratchpad "$1" "name" "$1" "$kitty --listen-on=unix:@scratchpad_vifm --title "$1" env TERM=kitty-direct ~/.config/vifm/scripts/vifmrun ~ &" ;;
    "scratchpad_btop") toggle_scratchpad "$1" "name" "$1" "$kitty --listen-on=unix:@scratchpad_btop --title "$1" btop &" ;;
    "scratchpad_lazygit") toggle_scratchpad "$1" "name" "$1" "$kitty --listen-on=unix:@scratchpad_lazygit --title "$1" ~/go/bin/lazygit &" ;;
        # "scratchpad_vivaldi") toggle_scratchpad "$1" "class" "Vivaldi-stable" 'vivaldi' ;;
    "kitty_term")
        # $kitty --listen-on=unix:/tmp/kitty_remote --title kitty_term &
        $kitty
        local id=$(eval 'xdotool search --name $1')
        hide_all_windows_except "$id"
        sleep 0.4
        # $kitty @ --to unix:@"$1" set-font-size $font_size
        ;;
    "sxhkd")
        pkill --signal=9 sxhkd
        sxhkd -s /run/user/1000/sxhkd.fifo -a Return &
        dunstify -h string:x-dunst-stack-tag:control "sxhkd" -h string:x-dunst-stack-tag:control "Settings Reloaded"
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
