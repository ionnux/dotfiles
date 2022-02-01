#!/bin/bash

previous_window=$(xdotool getactivewindow getwindowname)

case "$1" in
    "terminal [1]")
        i3-msg '[title="terminal \[1\]"] scratchpad show'

        sleep 0.1
        current_window=$(xdotool getactivewindow getwindowname)

        if [ "$current_window" = "terminal [1]" ] && [ "$previous_window" == "terminal [2]" ]
        then
            i3-msg '[title="terminal \[2\]"] move absolute position 968 px 47 px, resize set 937 px 900 px'
            i3-msg '[title="terminal \[1\]"] move absolute position 15 px 47 px, resize set 937 px 900 px'
        else
            i3-msg '[title="terminal \[2\]"] move absolute position 15 px 47 px, resize set 1890 px 900 px'
        fi

        ;;

    "terminal [2]")
        i3-msg '[title="terminal \[2\]"] scratchpad show'

        sleep 0.1
        current_window=$(xdotool getactivewindow getwindowname)

        if [ "$current_window" = "terminal [2]" ] && [ "$previous_window" == "terminal [1]" ]
        then
            i3-msg '[title="terminal \[2\]"] move absolute position 968 px 47 px, resize set 937 px 900 px'
            i3-msg '[title="terminal \[1\]"] move absolute position 15 px 47 px, resize set 937 px 900 px'
        else
            i3-msg '[title="terminal \[1\]"] move absolute position 15 px 47 px, resize set 1890 px 900 px'
        fi

        ;;

      "cmus")
        i3-msg '[all] move scratchpad'
        i3-msg '[title="cmus"] scratchpad show'
        ;;
esac
