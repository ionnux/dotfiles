#!/bin/bash

previous_window=$(xdotool getactivewindow getwindowname)

case "$1" in
    "dropdown_terminal1")
        i3-msg '[title="dropdown_terminal1"] scratchpad show'

        sleep 0.1
        current_window=$(xdotool getactivewindow getwindowname)

        if [ "$current_window" = "dropdown_terminal1" ] && [ "$previous_window" == "dropdown_terminal2" ]
        then
            i3-msg '[title="dropdown_terminal2"] move absolute position 968 px 47 px, resize set 937 px 850 px'
            i3-msg '[title="dropdown_terminal1"] move absolute position 15 px 47 px, resize set 937 px 850 px'
        else
            i3-msg '[title="dropdown_terminal2"] move absolute position 15 px 47 px, resize set 1890 px 850 px'
        fi

        ;;

    "dropdown_terminal2")
        i3-msg '[title="dropdown_terminal2"] scratchpad show'

        sleep 0.1
        current_window=$(xdotool getactivewindow getwindowname)

        if [ "$current_window" = "dropdown_terminal2" ] && [ "$previous_window" == "dropdown_terminal1" ]
        then
            i3-msg '[title="dropdown_terminal2"] move absolute position 968 px 47 px, resize set 937 px 850 px'
            i3-msg '[title="dropdown_terminal1"] move absolute position 15 px 47 px, resize set 937 px 850 px'
        else
            i3-msg '[title="dropdown_terminal1"] move absolute position 15 px 47 px, resize set 1890 px 850 px'
        fi

        ;;
esac
