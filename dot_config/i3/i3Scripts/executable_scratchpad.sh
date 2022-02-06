#!/bin/bash

previous_window=$(xdotool getactivewindow getwindowname)

split_screen_between_terminals () {
    case "$1" in
        "top")
            # split the screen between dropdown_terminal [1] and dropdown_terminal [2]
            i3-msg '[title="dropdown_terminal \[2\]"] move absolute position 967 px 47 px, resize set 939 px 900 px'
            i3-msg '[title="dropdown_terminal \[1\]"] move absolute position 14 px 47 px, resize set 939 px 900 px'
            ;;

        "right")
            # split the screen between dropdown_terminal [1] and dropdown_terminal [2]
            i3-msg '[title="dropdown_terminal \[1\]"] move absolute position 967 px 47 px, resize set 939 px 502 px'
            i3-msg '[title="dropdown_terminal \[2\]"] move absolute position 967 px 563 px, resize set 939 px 502 px'
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
            i3-msg '[title="dropdown_terminal \['$terminal'\]"] move absolute position 14 px 47 px, resize set 1892 px 900 px' # make dropdown_terminal [1] fullscreen
            ;;

        "right")
            i3-msg '[title="dropdown_terminal \['$terminal'\]"] move absolute position 967 px 47 px, resize set 939 px 1018 px' # make dropdown_terminal [2] fullscreen
            ;;
    esac
}

case "$1" in
    "dropdown_terminal [1]")

        i3-msg '[title="dropdown_terminal \[1\]"] scratchpad show'
        i3-msg '[title="dropdown_cmus"] move scratchpad'
        i3-msg '[title="dropdown_vifm"] move scratchpad'
        i3-msg '[title="dropdown_scrcpy"] move scratchpad'

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
        i3-msg '[title="dropdown_cmus"] move scratchpad'
        i3-msg '[title="dropdown_vifm"] move scratchpad'
        i3-msg '[title="dropdown_scrcpy"] move scratchpad'

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

    "dropdown_cmus")
        i3-msg '[title="dropdown_cmus"] scratchpad show'
        i3-msg '[title="dropdown_terminal*"] move scratchpad'
        i3-msg '[title="dropdown_vifm"] move scratchpad'
        i3-msg '[title="dropdown_scrcpy"] move scratchpad'
        ;;

    "dropdown_vifm")
        i3-msg '[title="dropdown_vifm"] scratchpad show'
        i3-msg '[title="dropdown_terminal*"] move scratchpad'
        i3-msg '[title="dropdown_cmus"] move scratchpad'
        i3-msg '[title="dropdown_scrcpy"] move scratchpad'
        ;;

    "dropdown_scrcpy")
        i3-msg '[title="dropdown_scrcpy"] scratchpad show'
        i3-msg '[title="dropdown_terminal*"] move scratchpad'
        i3-msg '[title="dropdown_cmus"] move scratchpad'
        i3-msg '[title="dropdown_vifm"] move scratchpad'
        ;;
esac
