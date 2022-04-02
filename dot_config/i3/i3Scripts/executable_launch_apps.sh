#!/bin/bash

kitty=~/.local/kitty.app/bin/kitty
split="no"

move_to_scratchpad_except () {
    windows=$(xdotool search --desktop $(xdotool get_desktop) --name auto getwindowname %@)
    echo "$windows" | while read -r line; do
        if [[ "$line" != "$1" ]]; then
            case $line in
                'auto_vifm') i3-msg '[title="auto_vifm"] move scratchpad' ;;
                'auto_scrcpy') i3-msg '[title="auto_scrcpy"] move scratchpad' ;;
                'auto_ncmpcpp') i3-msg '[title="auto_ncmpcpp"] move scratchpad' ;;
                'auto_terminal[1]') i3-msg '[title="auto_terminal\[1\]"] move scratchpad' ;;
                'auto_terminal[2]') i3-msg '[title="auto_terminal\[2\]"] move scratchpad' ;;
            esac
        fi
    done
}

scratchpad_show () {
    case $1 in
        'auto_vifm') i3-msg '[title="auto_vifm"] scratchpad show' ;;
        'auto_scrcpy') i3-msg '[title="auto_scrcpy"] scratchpad show' ;;
        'auto_ncmpcpp') i3-msg '[title="auto_ncmpcpp"] scratchpad show' ;;
        'auto_terminal[1]') i3-msg '[title="auto_terminal\[1\]"] scratchpad show' ;;
        'auto_terminal[2]') i3-msg '[title="auto_terminal\[2\]"] scratchpad show' ;;
    esac
}

case "$1" in
    "auto_terminal[1]")
        if ! pgrep -a kitty | grep -F 'auto_terminal[1]'; then
            $kitty --listen-on=unix:@"auto_terminal[1]" --title 'auto_terminal[1]'
        fi

        if [[ "$split" == "no" ]]; then
            move_to_scratchpad_except "auto_terminal[1]"
        fi
        scratchpad_show "auto_terminal[1]"
        ~/.config/i3/i3Scripts/change_display_properties.sh
        ;;

    "auto_terminal[2]")
        if ! pgrep -a kitty | grep -F 'auto_terminal[2]'; then
            $kitty --listen-on=unix:@"auto_terminal[2]" --title 'auto_terminal[2]'
        fi

        if [[ "$split" == "no" ]]; then
            move_to_scratchpad_except "auto_terminal[2]"
        fi
        scratchpad_show "auto_terminal[2]"
        ~/.config/i3/i3Scripts/change_display_properties.sh
        ;;

    "auto_ncmpcpp")
        if ! pgrep -a kitty | grep auto_ncmpcpp; then
            $kitty --listen-on=unix:@auto_ncmpcpp --title auto_ncmpcpp ~/.config/ncmpcpp/ncmpcpp-ueberzug/ncmpcpp-ueberzug &
        fi

        if [[ "$split" == "no" ]]; then
            move_to_scratchpad_except "auto_ncmpcpp"
        fi

        scratchpad_show "auto_ncmpcpp"
        ~/.config/i3/i3Scripts/change_display_properties.sh

        ;;

    "auto_vifm")
        if ! pgrep -a kitty | grep auto_vifm; then
            $kitty --listen-on=unix:@auto_vifm --title auto_vifm ~/.config/vifm/scripts/vifmrun ~ &
        fi

        if [[ "$split" == "no" ]]; then
            move_to_scratchpad_except "auto_vifm"
        fi
        scratchpad_show "auto_vifm"
        ~/.config/i3/i3Scripts/change_display_properties.sh
        ;;

    "auto_fullterm")
        $kitty --listen-on=unix:/tmp/kitty_remote --title auto_fullterm &
        disown
        move_to_scratchpad_except "auto_fullterm"
        sleep 0.2
        ~/.config/i3/i3Scripts/change_display_properties.sh
        ;;

    "auto_scrcpy")
        if ! pgrep -a scrcpy | grep auto_scrcpy; then
            scrcpy --window-title 'auto_scrcpy' --tcpip -Sw &
        fi

        if [[ "$split" == "no" ]]; then
            move_to_scratchpad_except "auto_scrcpy"
        fi
        scratchpad_show "auto_scrcpy"
        ~/.config/i3/i3Scripts/change_display_properties.sh
        # i3-msg '[title="auto_scrcpy"] scratchpad show, resize set 408 px 880 px, move absolute position 1490 px 83 px'
        ;;

    "launcher")
        focused_output=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).output')
        if [ "$focused_output" = "eDP1" ]; then
            font="Iosevka 13"
        else
            font="Iosevka 16"
        fi

        rofi -show drun -display-drun launcher -config ~/.config/rofi/dmenu.rasi -theme-str "configuration {font: \"$font\";}"
        # rofi -modi "calc:~/.config/rofi/scripts/official/rofi-calc.sh" -show calc
        ;;
esac
