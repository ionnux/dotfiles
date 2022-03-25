#!/bin/bash

kitty=~/.local/kitty.app/bin/kitty
focused_output=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).output')
windows=$(xdotool search --desktop $(xdotool get_desktop) --class kitty getwindowname %@)

display_primary=$(xrandr --listactivemonitors | awk 'FNR == 2 {print $4}')
display_other=$(xrandr --listactivemonitors | awk 'FNR == 3 {print $4}')
display_primary_x=$(xrandr | grep $display_primary | grep -E -o '[[:digit:]]{4}x[[:digit:]]{4}' | awk -F 'x' '{print $1}')
display_primary_y=$(xrandr | grep $display_primary | grep -E -o '[[:digit:]]{4}x[[:digit:]]{4}' | awk -F 'x' '{print $2}')
display_other_x=$(xrandr | grep $display_other | grep -E -o '[[:digit:]]{4}x[[:digit:]]{4}' | awk -F 'x' '{print $1}')
display_other_y=$(xrandr | grep $display_other | grep -E -o '[[:digit:]]{4}x[[:digit:]]{4}' | awk -F 'x' '{print $2}')
display_primary_start_position=$(xrandr | grep $display_primary | grep -E -o '[[:digit:]]{4}x[[:digit:]]{4}\+[[:digit:]]*' | awk -F '+' '{print $2}')
display_other_start_position=$(xrandr | grep $display_other | grep -E -o '[[:digit:]]{4}x[[:digit:]]{4}\+[[:digit:]]*' | awk -F '+' '{print $2}')

if [ "$focused_output" = "eDP1" ]; then
    start_pos="$display_primary_start_position"
else
    start_pos="$display_other_start_position"
fi

vifm_position="top"
ncmpcpp_position="top"
terminal1_position="top"
terminal2_position="top"
scrcpy_position="right"

primary_top_y_size=950
primary_top_x_size=$display_primary_x
primary_top_y_position=0
primary_top_x_position=$start_pos

primary_right_left_gap=10
primary_right_left_y_size=$((  display_primary_y - 134 ))
primary_right_left_x_size=$(( (display_primary_x / 2) - (primary_right_left_gap / 2) ))
primary_right_x_position=$(( start_pos + (display_primary_x / 2) + (primary_right_left_gap / 2) ))
primary_left_x_position=0
primary_right_left_y_position="34"
other_right_left_gap=10
other_right_left_y_size=$((  display_other_y - 38 ))
other_right_left_x_size=$(( (display_other_x / 2) - (other_right_left_gap / 2) ))
other_right_x_position=$(( start_pos + (display_other_x / 2) + (other_right_left_gap / 2) ))
other_left_x_position=$start_pos
other_right_left_y_position="38"

find_position () {
    case $1 in
        'dropdown_vifm') position="$vifm_position" ;;
        'dropdown_ncmpcpp') position="$ncmpcpp_position" ;;
        'dropdown_terminal[1]') position="$terminal1_position" ;;
        'dropdown_terminal[2]') position="$terminal2_position" ;;
        'dropdown_scrcpy') position="$scrcpy_position" ;;
    esac
}

change_size_and_position_other () {
    if [[ "$2" == "top" ]]; then
        case $1 in
            'dropdown_vifm') eval "i3-msg '[title=\"dropdown_vifm\"] resize set $display_other_x px 1000 px, \
              move absolute position $start_pos px 38 px'" ;;

            'dropdown_ncmpcpp') eval "i3-msg '[title=\"dropdown_ncmpcpp\"] resize set $display_other_x px 920 px, \
              move absolute position $start_pos px 38 px'" ;;

            'dropdown_terminal[1]') eval "i3-msg '[title=\"dropdown_terminal\[1\]\"] resize set $display_other_x px 1000 px, \
              move absolute position $start_pos px 38 px'" ;;

            'dropdown_terminal[2]') eval "i3-msg '[title=\"dropdown_terminal\[2\]\"] resize set $display_other_x px 1000 px, \
              move absolute position $start_pos px 38 px'" ;;
        esac

    else
        case $2 in
            'right') other_right_left_x_position=$other_right_x_position ;;
            'left') other_right_left_x_position=$other_left_x_position ;;
        esac

        case $1 in
            'dropdown_vifm') eval "i3-msg '[title=\"dropdown_vifm\"] resize set $other_right_left_x_size px $other_right_left_y_size px, \
              move absolute position $other_right_left_x_position px $other_right_left_y_position px'" ;;

            'dropdown_ncmpcpp') eval "i3-msg '[title=\"dropdown_ncmpcpp\"] resize set $display_other_x px 920 px, \
              move absolute position $start_pos px $other_right_left_y_position px'" ;;

            'dropdown_terminal[1]') eval "i3-msg '[title=\"dropdown_terminal\[1\]\"] resize set $other_right_left_x_size px $other_right_left_y_size px, \
              move absolute position $other_right_left_x_position px $other_right_left_y_position px'" ;;

            'dropdown_terminal[2]') eval "i3-msg '[title=\"dropdown_terminal\[2\]\"] resize set $other_right_left_x_size px $other_right_left_y_size px, \
              move absolute position $other_right_left_x_position px $other_right_left_y_position px'" ;;
        esac
    fi
}

change_size_and_position_primary () {
    if [[ "$2" == "top" ]]; then
        case $1 in
            'dropdown_vifm') eval "i3-msg '[title=\"dropdown_vifm\"] resize set $primary_top_x_size px $primary_top_y_size px, \
              move absolute position $primary_top_x_position px $primary_top_y_position px'" ;;

            'dropdown_ncmpcpp') eval "i3-msg '[title=\"dropdown_ncmpcpp\"] resize set $primary_top_x_size px 910 px, \
              move absolute position $primary_top_x_position px $primary_top_y_position px'" ;;

            'dropdown_terminal[1]') eval "i3-msg '[title=\"dropdown_terminal\[1\]\"] resize set $primary_top_x_size px $primary_top_y_size px, \
              move absolute position $primary_top_x_position px $primary_top_y_position px'" ;;

            'dropdown_terminal[2]') eval "i3-msg '[title=\"dropdown_terminal\[2\]\"] resize set $primary_top_x_size px $primary_top_y_size px, \
              move absolute position $primary_top_x_position px $primary_top_y_position px'" ;;
        esac

    else

        case $2 in
            'right') primary_right_left_x_position=$primary_right_x_position ;;
            'left') primary_right_left_x_position=$primary_left_x_position ;;
        esac

        case $1 in
            'dropdown_vifm') eval "i3-msg '[title=\"dropdown_vifm\"] resize set $primary_right_left_x_size px $primary_right_left_y_size px, \
              move absolute position $primary_right_left_x_position px $primary_right_left_y_position px'" ;;

            'dropdown_ncmpcpp') eval "i3-msg '[title=\"dropdown_ncmpcpp\"] resize set $primary_right_left_x_size px $primary_right_left_y_size px, \
              move absolute position $primary_right_left_x_position px $primary_right_left_y_position px'" ;;
                # 'dropdown_ncmpcpp') eval "i3-msg '[title=\"dropdown_ncmpcpp\"] resize set $display_primary_x px 910 px, \
                    # move absolute position $start_pos px $primary_right_left_y_position px'" ;;

            'dropdown_scrcpy') eval "i3-msg '[title=\"dropdown_scrcpy\"] resize set 389 px 860 px, \
              move absolute position 1515 px 860 px'" ;;

            'dropdown_terminal[1]') eval "i3-msg '[title=\"dropdown_terminal\[1\]\"] resize set $primary_right_left_x_size px $primary_right_left_y_size px, \
              move absolute position $primary_right_left_x_position px $primary_right_left_y_position px'" ;;

            'dropdown_terminal[2]') eval "i3-msg '[title=\"dropdown_terminal\[2\]\"] resize set $primary_right_left_x_size px $primary_right_left_y_size px, \
              move absolute position $primary_right_left_x_position px $primary_right_left_y_position px'" ;;
        esac
    fi
}


change_size_and_position () {
    if [[ "$1" != "" ]]; then
        if [ "$focused_output" = "eDP1" ]; then
            change_size_and_position_primary "$1" "$2"
        else
            change_size_and_position_other "$1" "$2"
        fi
    fi
}

change_font_desktop_primary () {
    case $1 in
        'dropdown_vifm') $kitty @ --to unix:@dropdown_vifm set-font-size 14 ;;
        'dropdown_ncmpcpp') $kitty @ --to unix:@dropdown_ncmpcpp set-font-size 14 ;;
        'dropdown_terminal[1]') $kitty @ --to unix:@"dropdown_terminal[1]" set-font-size 14 ;;
        'dropdown_terminal[2]') $kitty @ --to unix:@"dropdown_terminal[2]" set-font-size 14 ;;
        'full_terminal')
            sleep 0.2
            $kitty @ --to unix:/tmp/kitty_remote set-font-size 14
            ;;
    esac
}

change_font_desktop_others () {
    case $1 in
        'dropdown_vifm') $kitty @ --to unix:@dropdown_vifm set-font-size 18 ;;
        'dropdown_ncmpcpp') $kitty @ --to unix:@dropdown_ncmpcpp set-font-size 18 ;;
        'dropdown_terminal[1]') $kitty @ --to unix:@"dropdown_terminal[1]" set-font-size 18 ;;
        'dropdown_terminal[2]') $kitty @ --to unix:@"dropdown_terminal[2]" set-font-size 18 ;;
        'full_terminal')
            sleep 0.2
            $kitty @ --to unix:/tmp/kitty_remote set-font-size 18
            ;;
    esac
}

change_font () {
    if [[ "$1" != "" ]]; then
        if [ "$focused_output" = "eDP1" ]; then
            change_font_desktop_primary "$1"
        else
            change_font_desktop_others "$1"
        fi
    fi
}

move_to_scratchpad () {
    case $1 in
        'dropdown_vifm') i3-msg '[title="dropdown_vifm"] move scratchpad' ;;
        'dropdown_scrcpy') i3-msg '[title="dropdown_scrcpy"] move scratchpad' ;;
        'dropdown_ncmpcpp') i3-msg '[title="dropdown_ncmpcpp"] move scratchpad' ;;
        'dropdown_terminal[1]') i3-msg '[title="dropdown_terminal\[1\]"] move scratchpad' ;;
        'dropdown_terminal[2]') i3-msg '[title="dropdown_terminal\[2\]"] move scratchpad' ;;
    esac
}

move_all_to_scratchpad () {
    while read -r line; do
        if [[ "$line" != "$1" ]]; then
            case $line in
                'dropdown_vifm') i3-msg '[title="dropdown_vifm"] move scratchpad' ;;
                'dropdown_scrcpy') i3-msg '[title="dropdown_scrcpy"] move scratchpad' ;;
                'dropdown_ncmpcpp') i3-msg '[title="dropdown_ncmpcpp"] move scratchpad' ;;
                'dropdown_terminal[1]') i3-msg '[title="dropdown_terminal\[1\]"] move scratchpad' ;;
                'dropdown_terminal[2]') i3-msg '[title="dropdown_terminal\[2\]"] move scratchpad' ;;
            esac
        fi
    done <<< "$windows"
}

while read -r line; do
    case $line in
        'dropdown_vifm')
            window_array+=( "$line" )
            ;;
        'dropdown_ncmpcpp')
            window_array+=( "$line" )
            ;;
        'dropdown_terminal[1]')
            window_array+=( "$line" )
            ;;
        'dropdown_terminal[2]')
            window_array+=( "$line" )
            ;;
    esac
done <<< "$windows"

case ${#window_array[@]} in
    '1')
        window_name="${window_array[0]}"
        find_position "$window_name"
        change_font "$window_name"
        change_size_and_position "$window_name" "$position"
        ;;
    *)
        stop_range=$(( ${#window_array[@]} - 3 ))
        for (( i = 0; i <= $stop_range; i++ )); do
            move_to_scratchpad "${window_array[i]}"
        done

        change_font "${window_array[-1]}"
        change_font "${window_array[-2]}"
        change_size_and_position "${window_array[-1]}" "right"
        change_size_and_position "${window_array[-2]}" "left"
        ;;
esac
