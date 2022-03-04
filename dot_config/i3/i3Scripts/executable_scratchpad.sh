#!/bin/bash

previous_window=$(xdotool getactivewindow getwindowname)
kitty=~/.local/kitty.app/bin/kitty

split_screen_between_terminals () {
    case "$1" in
        "top")
            # split the screen between dropdown_terminal [1] and dropdown_terminal [2]
            i3-msg '[title="dropdown_terminal \[2\]"] move absolute position 967 px 34 px, resize set 953 px 900 px'
            i3-msg '[title="dropdown_terminal \[1\]"] move absolute position 0 px 34 px, resize set 953 px 900 px'
            ;;

        "right")
            # split the screen between dropdown_terminal [1] and dropdown_terminal [2]
            i3-msg '[title="dropdown_terminal \[1\]"] move absolute position 967 px 34 px, resize set 952 px 517 px'
            i3-msg '[title="dropdown_terminal \[2\]"] move absolute position 967 px 563 px, resize set 952 px 517 px'
            ;;
    esac
}

make_terminal_full_screen () {
    terminal=""

    case "$1" in
        "dropdown_terminal [1]")
            terminal="1"
            ;;
        "dropdown_terminal [2]")
            terminal="2"
            ;;
    esac

    case "$2" in
        "top")
            i3-msg '[title="dropdown_terminal \['$terminal'\]"] move absolute position 0 px 34 px, resize set 1920 px 900 px' # make dropdown_terminal [1] fullscreen
            ;;

        "right")
            i3-msg '[title="dropdown_terminal \['$terminal'\]"] move absolute position 967 px 34 px, resize set 951 px 1046 px' # make dropdown_terminal [2] fullscreen
            ;;
    esac
}

case "$1" in
    "dropdown_terminal [1]")

        i3-msg '[title="dropdown_terminal \[1\]"] scratchpad show'
        i3-msg '[title="dropdown_ncmpcpp"] move scratchpad'
        i3-msg '[title="dropdown_vifm"] move scratchpad'
        i3-msg '[title="dropdown_scrcpy"] move scratchpad'

        # if terminal 1 does not exist
        if ! pgrep -a kitty | grep -F 'dropdown_terminal [1]'
        then
            $kitty --title 'dropdown_terminal [1]' &
            sleep 0.4
        fi

        sleep 0.1
        current_window=$(xdotool getactivewindow getwindowname)

        if [ "$current_window" = "dropdown_terminal [1]" ]  # dropdown_terminal [1] is being shown
        then
            if [ "$previous_window" = "dropdown_terminal [2]" ] # dropdown_terminal [2] is already visible
            then
                case "$2" in
                    "top")
                        # split the screen between dropdown_terminal [1] and dropdown_terminal [2]
                        split_screen_between_terminals "top"
                        ;;

                    "right")
                        # split the screen between dropdown_terminal [1] and dropdown_terminal [2]
                        split_screen_between_terminals "right"
                        ;;
                esac
            else
                case "$2" in
                    "top")
                        make_terminal_full_screen "dropdown_terminal [1]" "top"
                        ;;

                    "right")
                        make_terminal_full_screen "dropdown_terminal [1]" "right"
                        ;;
                esac
            fi
        else # dropdown_terminal [1] is being moved to the scratchpad
            # maximixe dropdown_terminal [2], it does'nt matter if it's present or not
            case "$2" in
                "top")
                    make_terminal_full_screen "dropdown_terminal [2]" "top"
                    ;;

                "right")
                    make_terminal_full_screen "dropdown_terminal [2]" "right"
                    ;;
            esac
        fi

        ;;

    "dropdown_terminal [2]")
        i3-msg '[title="dropdown_terminal \[2\]"] scratchpad show'
        i3-msg '[title="dropdown_ncmpcpp"] move scratchpad'
        i3-msg '[title="dropdown_vifm"] move scratchpad'
        i3-msg '[title="dropdown_scrcpy"] move scratchpad'

        # if terminal 2 does not exist
        if ! pgrep -a kitty | grep -F 'dropdown_terminal [2]'
        then
            $kitty --title 'dropdown_terminal [2]' &
            sleep 0.4
        fi

        sleep 0.1
        current_window=$(xdotool getactivewindow getwindowname)

        if [ "$current_window" = "dropdown_terminal [2]" ]
        then
            if [ "$previous_window" = "dropdown_terminal [1]" ]
            then
                case "$2" in

                    "top")
                        # split the screen between dropdown_terminal [1] and dropdown_terminal [2]
                        split_screen_between_terminals "top"
                        ;;

                    "right")
                        # split the screen between dropdown_terminal [1] and dropdown_terminal [2]
                        split_screen_between_terminals "right"
                        ;;

                esac
            else
                case "$2" in
                    "top")
                        make_terminal_full_screen "dropdown_terminal [2]" "top"
                        ;;

                    "right")
                        make_terminal_full_screen "dropdown_terminal [2]" "right"
                        ;;
                esac
            fi
        else
            case "$2" in
                "top")
                    make_terminal_full_screen "dropdown_terminal [1]" "top"
                    ;;

                "right")
                    make_terminal_full_screen "dropdown_terminal [1]" "right"
                    ;;
            esac
        fi
        ;;

    "dropdown_ncmpcpp")
        i3-msg '[title="dropdown_ncmpcpp"] scratchpad show'
        i3-msg '[title="dropdown_terminal*"] move scratchpad'
        i3-msg '[title="dropdown_vifm"] move scratchpad'
        i3-msg '[title="dropdown_scrcpy"] move scratchpad'
        ;;

    "dropdown_vifm")
        i3-msg '[title="dropdown_vifm"] scratchpad show'
        i3-msg '[title="dropdown_terminal*"] move scratchpad'
        i3-msg '[title="dropdown_scrcpy"] move scratchpad'
        i3-msg '[title="dropdown_ncmpcpp"] move scratchpad'
        ;;

    "dropdown_scrcpy")
        i3-msg '[title="dropdown_scrcpy"] scratchpad show'
        i3-msg '[title="dropdown_terminal*"] move scratchpad'
        i3-msg '[title="dropdown_vifm"] move scratchpad'
        i3-msg '[title="dropdown_ncmpcpp"] move scratchpad'
        ;;

    "dropdown_menu")
        # i3-dmenu-desktop --dmenu="rofi -config ~/.config/rofi/dmenu.rasi -i -p 'Launcher' -dmenu"
        rofi -show combi -config ~/.config/rofi/dmenu.rasi
        # i3-dmenu-desktop --dmenu='dmenu -i -f -nb #24283b -nf #c0caf5 -sb #bb9af7 -p Launcher -sf #24283b -fn Iosevka'
        # $kitty --title 'dropdown_menu' i3-dmenu-desktop --dmenu='fzf --reverse --ansi --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7 '

        ;;
esac
