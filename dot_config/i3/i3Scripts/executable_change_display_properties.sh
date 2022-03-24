#!/bin/bash

display_primary=$(xrandr --listactivemonitors | awk 'FNR == 2 {print $4}')
display_other=$(xrandr --listactivemonitors | awk 'FNR == 3 {print $4}')
display_primary_x=$(xrandr | grep $display_primary | grep -E -o '[[:digit:]]{4}x[[:digit:]]{4}' | awk -F 'x' '{print $1}')
display_primary_y=$(xrandr | grep $display_primary | grep -E -o '[[:digit:]]{4}x[[:digit:]]{4}' | awk -F 'x' '{print $2}')
display_other_x=$(xrandr | grep $display_other | grep -E -o '[[:digit:]]{4}x[[:digit:]]{4}' | awk -F 'x' '{print $1}')
display_other_y=$(xrandr | grep $display_other | grep -E -o '[[:digit:]]{4}x[[:digit:]]{4}' | awk -F 'x' '{print $2}')
display_primary_start_position=$(xrandr | grep $display_primary | grep -E -o '[[:digit:]]{4}x[[:digit:]]{4}\+[[:digit:]]*' | awk -F '+' '{print $2}')
display_other_start_position=$(xrandr | grep $display_other | grep -E -o '[[:digit:]]{4}x[[:digit:]]{4}\+[[:digit:]]*' | awk -F '+' '{print $2}')

vifm_position="top"
ncmpcpp_position="top"
terminal1_position="top"
terminal2_position="top"
scrcpy_position="right"

kitty=~/.local/kitty.app/bin/kitty
focused_output=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).output')
windows=$(xdotool search --desktop $(xdotool get_desktop) --class kitty getwindowname %@)

find_position () {
    case $1 in
        'dropdown_vifm') position="$vifm_position" ;;
        'dropdown_ncmpcpp') position="$ncmpcpp_position" ;;
        'dropdown_terminal [1]') position="$terminal1_position" ;;
        'dropdown_terminal [2]') position="$terminal2_position" ;;
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

            'dropdown_terminal [1]') eval "i3-msg '[title=\"dropdown_terminal \[1\]\"] resize set $display_other_x px 1000 px, \
              move absolute position $start_pos px 38 px'" ;;

            'dropdown_terminal [2]') eval "i3-msg '[title=\"dropdown_terminal \[2\]\"] resize set $display_other_x px 1000 px, \
              move absolute position $start_pos px 38 px'" ;;
        esac

    elif [[ "$2" == "right" ]]; then
        case $1 in
            'dropdown_vifm') eval "i3-msg '[title=\"dropdown_vifm\"] resize set $(( display_other_x / 2 )) px $(( display_other_y - 38 )) px, \
              move absolute position $(( start_pos + (display_other_x / 2) )) px 38 px'" ;;

            'dropdown_ncmpcpp') eval "i3-msg '[title=\"dropdown_ncmpcpp\"] resize set $display_other_x px 920 px, \
              move absolute position $start_pos px 38 px'" ;;

            'dropdown_terminal [1]') eval "i3-msg '[title=\"dropdown_terminal \[1\]\"] resize set $(( display_other_x / 2 )) px $(( display_other_y - 38 )) px, \
              move absolute position $(( start_pos + (display_other_x / 2) )) px 38 px'" ;;

            'dropdown_terminal [2]') eval "i3-msg '[title=\"dropdown_terminal \[2\]\"] resize set $(( display_other_x / 2 )) px $(( display_other_y - 38 )) px, \
              move absolute position $(( start_pos + (display_other_x / 2) )) px 38 px'" ;;
        esac
    fi
}

change_size_and_position_primary () {
    if [[ "$2" == "top" ]]; then
        case $1 in
            'dropdown_vifm') eval "i3-msg '[title=\"dropdown_vifm\"] resize set $display_primary_x px 900 px, \
              move absolute position $start_pos px 34 px'" ;;

            'dropdown_ncmpcpp') eval "i3-msg '[title=\"dropdown_ncmpcpp\"] resize set $display_primary_x px 910 px, \
              move absolute position $start_pos px 34 px'" ;;

            'dropdown_terminal [1]') eval "i3-msg '[title=\"dropdown_terminal \[1\]\"] resize set $display_primary_x px 900 px, \
              move absolute position $start_pos px 34 px'" ;;

            'dropdown_terminal [2]') eval "i3-msg '[title=\"dropdown_terminal \[2\]\"] resize set $display_primary_x px 900 px, \
              move absolute position $start_pos px 34 px'" ;;
        esac

    elif [[ "$2" == "right" ]]; then
        case $1 in
            'dropdown_vifm') eval "i3-msg '[title=\"dropdown_vifm\"] resize set $(( display_primary_x / 2 )) px $(( display_primary_y - 34 )) px, \
              move absolute position $(( start_pos + (display_primary_x / 2) )) px 34 px'" ;;

            'dropdown_ncmpcpp') eval "i3-msg '[title=\"dropdown_ncmpcpp\"] resize set $display_primary_x px 910 px, \
              move absolute position $start_pos px 34 px'" ;;

            'dropdown_scrcpy') eval "i3-msg '[title=\"dropdown_scrcpy\"] resize set 389 px 860 px, \
              move absolute position 1515 px 860 px'" ;;

            'dropdown_terminal [1]') eval "i3-msg '[title=\"dropdown_terminal \[1\]\"] resize set $(( display_primary_x / 2 )) px $(( display_primary_y - 34 )) px, \
              move absolute position $(( start_pos + (display_primary_x / 2) )) px 34 px'" ;;

            'dropdown_terminal [2]') eval "i3-msg '[title=\"dropdown_terminal \[2\]\"] resize set $(( display_primary_x / 2 )) px $(( display_primary_y - 34 )) px, \
              move absolute position $(( start_pos + (display_primary_x / 2) )) px 34 px'" ;;
        esac
    fi
}


change_size_and_position () {
    if [[ "$1" != "" ]]; then
        if [ "$focused_output" = "eDP1" ]; then
            start_pos="$display_primary_start_position"
            change_size_and_position_primary "$1" "$2"
        else
            start_pos="$display_other_start_position"
            change_size_and_position_other "$1" "$2"
        fi
    fi
}

change_font_desktop_primary () {
    case $1 in
        'dropdown_vifm') $kitty @ --to unix:@dropdown_vifm set-font-size 14 ;;
        'dropdown_ncmpcpp') $kitty @ --to unix:@dropdown_ncmpcpp set-font-size 14 ;;
        'dropdown_terminal [1]') $kitty @ --to unix:@"dropdown_terminal [1]" set-font-size 14 ;;
        'dropdown_terminal [2]') $kitty @ --to unix:@"dropdown_terminal [2]" set-font-size 14 ;;
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
        'dropdown_terminal [1]') $kitty @ --to unix:@"dropdown_terminal [1]" set-font-size 18 ;;
        'dropdown_terminal [2]') $kitty @ --to unix:@"dropdown_terminal [2]" set-font-size 18 ;;
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

echo "$windows" | while read -r line; do
    find_position "$line"
    change_font "$line"
    change_size_and_position "$line" "$position"
done
