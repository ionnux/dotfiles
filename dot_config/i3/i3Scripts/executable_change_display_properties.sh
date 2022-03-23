#!/bin/bash

display_0=$(xrandr --listactivemonitors | awk 'FNR == 2 {print $4}')
display_1=$(xrandr --listactivemonitors | awk 'FNR == 3 {print $4}')
display_0_x=$(xrandr | grep $display_0 | grep -E -o '[[:digit:]]{4}x[[:digit:]]{4}' | awk -F 'x' '{print $1}')
display_0_y=$(xrandr | grep $display_0 | grep -E -o '[[:digit:]]{4}x[[:digit:]]{4}' | awk -F 'x' '{print $2}')
display_1_x=$(xrandr | grep $display_1 | grep -E -o '[[:digit:]]{4}x[[:digit:]]{4}' | awk -F 'x' '{print $1}')
display_1_y=$(xrandr | grep $display_1 | grep -E -o '[[:digit:]]{4}x[[:digit:]]{4}' | awk -F 'x' '{print $2}')
display_0_start_pos=$(xrandr | grep $display_0 | grep -E -o '[[:digit:]]{4}x[[:digit:]]{4}\+[[:digit:]]*' | awk -F '+' '{print $2}')
display_1_start_pos=$(xrandr | grep $display_1 | grep -E -o '[[:digit:]]{4}x[[:digit:]]{4}\+[[:digit:]]*' | awk -F '+' '{print $2}')

kitty=~/.local/kitty.app/bin/kitty
desktop=$(xdotool get_desktop)
windows=$(xdotool search --desktop $(xdotool get_desktop) --class kitty getwindowname %@)

vifm_position="top"
ncmpcpp_position="top"
terminal1_position="top"
terminal2_position="top"

find_position () {
    case $1 in
        'dropdown_vifm') position="$vifm_position" ;;
        'dropdown_ncmpcpp') position="$ncmpcpp_position" ;;
        'dropdown_terminal [1]') position="$terminal1_position" ;;
        'dropdown_terminal [2]') position="$terminal2_position" ;;
    esac
}
change_size_desktop_primary () {
    if [[ "$position" == "top" ]]; then
        case $1 in
            'dropdown_vifm') eval "i3-msg '[title=\"dropdown_vifm\"] scratchpad show, move absolute position $start_pos px 34 px, resize set $display_0_x px 900 px'" ;;
            'dropdown_ncmpcpp') eval "i3-msg '[title=\"dropdown_ncmpcpp\"] scratchpad show, move absolute position $start_pos px 34 px, resize set $display_0_x px 880 px'" ;;
            'dropdown_terminal [1]') eval "i3-msg '[title=\"dropdown_terminal \[1\]\"] scratchpad show, move absolute position $start_pos px 34 px, resize set $display_0_x px 900 px'" ;;
            'dropdown_terminal [2]') eval "i3-msg '[title=\"dropdown_terminal \[2\]\"] scratchpad show, move absolute position $start_pos px 34 px, resize set $display_0_x px 900 px'" ;;
        esac
    elif [[ "$position" == "right" ]]; then
        case $1 in
            'dropdown_vifm') eval "i3-msg '[title=\"dropdown_vifm\"] scratchpad show, move absolute position $(( start_pos + (display_0_x / 2) )) px 34 px, resize set $(( display_0_x / 2 )) px $(( display_0_y - 34 )) px'" ;;
            'dropdown_ncmpcpp') eval "i3-msg '[title=\"dropdown_ncmpcpp\"] scratchpad show, move absolute position $start_pos px 34 px, resize set $display_0_x px 880 px'" ;;
            'dropdown_terminal [1]') eval "i3-msg '[title=\"dropdown_terminal \[1\]\"] scratchpad show, move absolute position $(( start_pos + (display_0_x / 2) )) px 34 px, resize set $(( display_0_x / 2 )) px $(( display_0_y - 34 )) px'" ;;
            'dropdown_terminal [2]') eval "i3-msg '[title=\"dropdown_terminal \[2\]\"] scratchpad show, move absolute position $(( start_pos + (display_0_x / 2) )) px 34 px, resize set $(( display_0_x / 2 )) px $(( display_0_y - 34 )) px'" ;;
        esac
    fi
}

change_size_desktop_others () {
    if [[ "$2" == "top" ]]; then
        case $1 in
            'dropdown_vifm') eval "i3-msg '[title=\"dropdown_vifm\"] scratchpad show, move absolute position $start_pos px 38 px, resize set $display_1_x px 1000 px'" ;;
            'dropdown_ncmpcpp') eval "i3-msg '[title=\"dropdown_ncmpcpp\"] scratchpad show, move absolute position $start_pos px 38 px, resize set $display_1_x px 920 px'" ;;
            'dropdown_terminal [1]') eval "i3-msg '[title=\"dropdown_terminal \[1\]\"] scratchpad show, move absolute position $start_pos px 38 px, resize set $display_1_x px 1000 px'" ;;
            'dropdown_terminal [2]') eval "i3-msg '[title=\"dropdown_terminal \[2\]\"] scratchpad show, move absolute position $start_pos px 38 px, resize set $display_1_x px 1000 px'" ;;
        esac
    elif [[ "$2" == "right" ]]; then
        case $1 in
            'dropdown_vifm') eval "i3-msg '[title=\"dropdown_vifm\"] scratchpad show, move absolute position $(( start_pos + (display_1_x / 2) )) px 38 px, resize set $(( display_1_x / 2 )) px $(( display_1_y - 38 )) px'" ;;
            'dropdown_ncmpcpp') eval "i3-msg '[title=\"dropdown_ncmpcpp\"] scratchpad show, move absolute position $start_pos px 38 px, resize set $display_1_x px 920 px'" ;;
            'dropdown_terminal [1]') eval "i3-msg '[title=\"dropdown_terminal \[1\]\"] scratchpad show, move absolute position $(( start_pos + (display_1_x / 2) )) px 38 px, resize set $(( display_1_x / 2 )) px $(( display_1_y - 38 )) px'" ;;
            'dropdown_terminal [2]') eval "i3-msg '[title=\"dropdown_terminal \[2\]\"] scratchpad show, move absolute position $(( start_pos + (display_1_x / 2) )) px 38 px, resize set $(( display_1_x / 2 )) px $(( display_1_y - 38 )) px'" ;;
        esac
    fi
}

change_size_other_auto () {
    if [[ "$2" == "top" ]]; then
        case $1 in
            'dropdown_vifm') eval "i3-msg '[title=\"dropdown_vifm\"] resize set $display_1_x px 1000 px'" ;;
            'dropdown_ncmpcpp') eval "i3-msg '[title=\"dropdown_ncmpcpp\"] resize set $display_1_x px 920 px'" ;;
            'dropdown_terminal [1]') eval "i3-msg '[title=\"dropdown_terminal \[1\]\"] resize set $display_1_x px 1000 px'" ;;
            'dropdown_terminal [2]') eval "i3-msg '[title=\"dropdown_terminal \[2\]\"] resize set $display_1_x px 1000 px'" ;;
        esac
    elif [[ "$2" == "right" ]]; then
        case $1 in
            'dropdown_vifm') eval "i3-msg '[title=\"dropdown_vifm\"] resize set $(( display_1_x / 2 )) px $(( display_1_y - 38 )) px'" ;;
            'dropdown_ncmpcpp') eval "i3-msg '[title=\"dropdown_ncmpcpp\"] resize set $display_1_x px 920 px'" ;;
            'dropdown_terminal [1]') eval "i3-msg '[title=\"dropdown_terminal \[1\]\"] resize set $(( display_1_x / 2 )) px $(( display_1_y - 38 )) px'" ;;
            'dropdown_terminal [2]') eval "i3-msg '[title=\"dropdown_terminal \[2\]\"] resize set $(( display_1_x / 2 )) px $(( display_1_y - 38 )) px'" ;;
        esac
    fi
}

change_size_primary_auto () {
    if [[ "$2" == "top" ]]; then
        case $1 in
            'dropdown_vifm') eval "i3-msg '[title=\"dropdown_vifm\"] resize set $display_0_x px 900 px'" ;;
            'dropdown_ncmpcpp') eval "i3-msg '[title=\"dropdown_ncmpcpp\"] resize set $display_0_x px 910 px'" ;;
            'dropdown_terminal [1]') eval "i3-msg '[title=\"dropdown_terminal \[1\]\"] resize set $display_0_x px 900 px'" ;;
            'dropdown_terminal [2]') eval "i3-msg '[title=\"dropdown_terminal \[2\]\"] resize set $display_0_x px 900 px'" ;;
        esac
    elif [[ "$2" == "right" ]]; then
        case $1 in
            'dropdown_vifm') eval "i3-msg '[title=\"dropdown_vifm\"] resize set $(( display_0_x / 2 )) px $(( display_0_y - 34 )) px'" ;;
            'dropdown_ncmpcpp') eval "i3-msg '[title=\"dropdown_ncmpcpp\"] resize set $display_0_x px 910 px'" ;;
            'dropdown_terminal [1]') eval "i3-msg '[title=\"dropdown_terminal \[1\]\"] resize set $(( display_0_x / 2 )) px $(( display_0_y - 34 )) px'" ;;
            'dropdown_terminal [2]') eval "i3-msg '[title=\"dropdown_terminal \[2\]\"] resize set $(( display_0_x / 2 )) px $(( display_0_y - 34 )) px'" ;;
        esac
    fi
}

change_position_other_auto () {
    if [[ "$2" == "top" ]]; then
        case $1 in
            'dropdown_vifm') eval "i3-msg '[title=\"dropdown_vifm\"] move absolute position $start_pos px 38 px'" ;;
            'dropdown_ncmpcpp') eval "i3-msg '[title=\"dropdown_ncmpcpp\"] move absolute position $start_pos px 38 px'" ;;
            'dropdown_terminal [1]') eval "i3-msg '[title=\"dropdown_terminal \[1\]\"] move absolute position $start_pos px 38 px'" ;;
            'dropdown_terminal [2]') eval "i3-msg '[title=\"dropdown_terminal \[2\]\"] move absolute position $start_pos px 38 px'" ;;
        esac
    elif [[ "$2" == "right" ]]; then
        case $1 in
            'dropdown_vifm') eval "i3-msg '[title=\"dropdown_vifm\"] move absolute position $(( start_pos + (display_1_x / 2) )) px 38 px'" ;;
            'dropdown_ncmpcpp') eval "i3-msg '[title=\"dropdown_ncmpcpp\"] move absolute position $start_pos px 38 px'" ;;
            'dropdown_terminal [1]') eval "i3-msg '[title=\"dropdown_terminal \[1\]\"] move absolute position $(( start_pos + (display_1_x / 2) )) px 38 px'" ;;
            'dropdown_terminal [2]') eval "i3-msg '[title=\"dropdown_terminal \[2\]\"] move absolute position $(( start_pos + (display_1_x / 2) )) px 38 px'" ;;
        esac
    fi
}

change_position_primary_auto () {
    if [[ "$2" == "top" ]]; then
        case $1 in
            'dropdown_vifm') eval "i3-msg '[title=\"dropdown_vifm\"] move absolute position $start_pos px 34 px'" ;;
            'dropdown_ncmpcpp') eval "i3-msg '[title=\"dropdown_ncmpcpp\"] move absolute position $start_pos px 34 px'" ;;
            'dropdown_terminal [1]') eval "i3-msg '[title=\"dropdown_terminal \[1\]\"] move absolute position $start_pos px 34 px'" ;;
            'dropdown_terminal [2]') eval "i3-msg '[title=\"dropdown_terminal \[2\]\"] move absolute position $start_pos px 34 px'" ;;
        esac
    elif [[ "$2" == "right" ]]; then
        case $1 in
            'dropdown_vifm') eval "i3-msg '[title=\"dropdown_vifm\"] move absolute position $(( start_pos + (display_0_x / 2) )) px 34 px'" ;;
            'dropdown_ncmpcpp') eval "i3-msg '[title=\"dropdown_ncmpcpp\"] move absolute position $start_pos px 34 px'" ;;
            'dropdown_terminal [1]') eval "i3-msg '[title=\"dropdown_terminal \[1\]\"] move absolute position $(( start_pos + (display_0_x / 2) )) px 34 px'" ;;
            'dropdown_terminal [2]') eval "i3-msg '[title=\"dropdown_terminal \[2\]\"] move absolute position $(( start_pos + (display_0_x / 2) )) px 34 px'" ;;
        esac
    fi
}

change_size_and_position_auto () {
    if [[ "$1" != "" ]]; then
        if [ "$desktop" = "0" ]; then
            start_pos="$display_0_start_pos"
            change_size_primary_auto "$1" "$2"
            change_position_primary_auto "$1" "$2"
        else
            start_pos="$display_1_start_pos"
            change_size_other_auto "$1" "$2"
            change_position_other_auto "$1" "$2"
        fi
    fi
}

change_size_and_position_manual () {
    if [[ "$1" != "" ]]; then
        if [ "$desktop" = "0" ]; then
            start_pos="$display_0_start_pos"
            change_size_desktop_primary "$1" "$2"
        else
            start_pos="$display_1_start_pos"
            change_size_desktop_others "$1" "$2"
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
        if [ "$desktop" = "0" ]; then
            change_font_desktop_primary "$1"
        else
            change_font_desktop_others "$1"
        fi
    fi
}


while getopts ':n:am' opt; do
    case "$opt" in
        n) name="$OPTARG" ;;
        a)
            echo "$windows" | while read -r line; do
                find_position "$line"
                change_font "$line"
                change_size_and_position_auto "$line" "$position"
            done
            ;;
        m)
            find_position "$name"
            change_font "$name"
            change_size_and_position_manual "$name" "$position"
            ;;
    esac
done
