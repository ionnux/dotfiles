#!/bin/bash

previous_window=$(xdotool getactivewindow getwindowname)

case "$1" in
    "terminal [1]")
        i3-msg '[title="terminal \[1\]"] scratchpad show'
        i3-msg '[title="cmus"] move scratchpad'

        sleep 0.1
        current_window=$(xdotool getactivewindow getwindowname)

        if [ "$current_window" = "terminal [1]" ]
        then
            if [ "$previous_window" = "terminal [2]" ]
            then
                i3-msg '[title="terminal \[2\]"] move absolute position 967 px 47 px, resize set 939 px 900 px'
                i3-msg '[title="terminal \[1\]"] move absolute position 14 px 47 px, resize set 939 px 900 px'
            else
                i3-msg '[title="terminal \[1\]"] move absolute position 14 px 47 px, resize set 1892 px 900 px'
            fi
        else
            i3-msg '[title="terminal \[2\]"] move absolute position 14 px 47 px, resize set 1892 px 900 px'
        fi
        ;;

    "terminal [2]")
        i3-msg '[title="terminal \[2\]"] scratchpad show'
        i3-msg '[title="cmus"] move scratchpad'

        sleep 0.1
        current_window=$(xdotool getactivewindow getwindowname)

        if [ "$current_window" = "terminal [2]" ]
        then
            if [ "$previous_window" = "terminal [1]" ]
            then
                i3-msg '[title="terminal \[2\]"] move absolute position 967 px 47 px, resize set 939 px 900 px'
                i3-msg '[title="terminal \[1\]"] move absolute position 14 px 47 px, resize set 939 px 900 px'
            else
                i3-msg '[title="terminal \[2\]"] move absolute position 14 px 47 px, resize set 1892 px 900 px'
            fi
        else
            i3-msg '[title="terminal \[1\]"] move absolute position 14 px 47 px, resize set 1892 px 900 px'
        fi
        ;;

    "cmus")
        i3-msg '[title="cmus"] scratchpad show'
        i3-msg '[title="terminal*"] move scratchpad'
        ;;
esac
