#!/bin/bash

kitty=~/.local/kitty.app/bin/kitty
desktop=$(xdotool get_desktop)

move_to_scratchpad () {
    windows=$(xdotool search --desktop $(xdotool get_desktop) --class kitty getwindowname %@)
    echo "$windows" | while read -r line; do
        if [[ "$line" != "$1" ]]; then
            case $line in
                'dropdown_vifm') i3-msg '[title="dropdown_vifm"] move scratchpad' ;;
                'dropdown_ncmpcpp') i3-msg '[title="dropdown_ncmpcpp"] move scratchpad' ;;
                'dropdown_terminal [1]') i3-msg '[title="dropdown_terminal \[1\]"] move scratchpad' ;;
                'dropdown_terminal [2]') i3-msg '[title="dropdown_terminal \[2\]"] move scratchpad' ;;
            esac
        fi
    done
}

case "$1" in
    "dropdown_terminal [1]")
        if ! pgrep -a kitty | grep -F 'dropdown_terminal [1]'; then
            $kitty --listen-on=unix:@"dropdown_terminal [1]" --title 'dropdown_terminal [1]'
        fi

        move_to_scratchpad "dropdown_terminal [1]"
        ~/.config/i3/i3Scripts/change_display_properties.sh -n "dropdown_terminal [1]" -m
        ;;

    "dropdown_terminal [2]")
        if ! pgrep -a kitty | grep -F 'dropdown_terminal [2]'; then
            $kitty --listen-on=unix:@"dropdown_terminal [2]" --title 'dropdown_terminal [2]'
        fi

        move_to_scratchpad "dropdown_terminal [2]"
        ~/.config/i3/i3Scripts/change_display_properties.sh -n "dropdown_terminal [2]" -m
        ;;

    "dropdown_ncmpcpp")
        if ! pgrep -a kitty | grep dropdown_ncmpcpp; then
            $kitty --listen-on=unix:@dropdown_ncmpcpp --title dropdown_ncmpcpp ~/.config/ncmpcpp/ncmpcpp-ueberzug/ncmpcpp-ueberzug &
        fi

        move_to_scratchpad "dropdown_ncmpcpp"
        ~/.config/i3/i3Scripts/change_display_properties.sh -n "dropdown_ncmpcpp" -m

        ;;

    "dropdown_vifm")
        if ! pgrep -a kitty | grep dropdown_vifm; then
            $kitty --listen-on=unix:@dropdown_vifm --title dropdown_vifm ~/.config/vifm/scripts/vifmrun ~ &
        fi

        move_to_scratchpad "dropdown_vifm"
        ~/.config/i3/i3Scripts/change_display_properties.sh -n "dropdown_vifm" -m
        ;;

    "full_terminal")
        $kitty --listen-on=unix:/tmp/kitty_remote --title full_terminal &
        move_to_scratchpad "full_terminal"
        ~/.config/i3/i3Scripts/change_display_properties.sh -n "full_terminal" -m
        ;;

    "dropdown_scrcpy")
        i3-msg '[title="dropdown_scrcpy"] scratchpad show'
        i3-msg '[title="dropdown_terminal*"] move scratchpad'
        i3-msg '[title="dropdown_vifm"] move scratchpad'
        i3-msg '[title="dropdown_ncmpcpp"] move scratchpad'
        ;;

    "dropdown_search")
        rofi -show run -p launcher -config ~/.config/rofi/dmenu.rasi
        ;;
esac
