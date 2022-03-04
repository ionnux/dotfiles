#!/bin/bash

windowname=$(xdotool getactivewindow getwindowname)

case "$windowname" in
    "dropdown_terminal [1]")
        i3-msg '[title="dropdown_terminal \[2\]"] move absolute position 0 px 34 px, resize set 1920 px 900 px'
        i3-msg '[title="dropdown_terminal \[1\]"] kill'
        ;;
    "dropdown_terminal [2]")
        i3-msg '[title="dropdown_terminal \[1\]"] move absolute position 0 px 34 px, resize set 1920 px 900 px'
        i3-msg '[title="dropdown_terminal \[2\]"] kill'
        ;;
    *)
        i3-msg 'kill'
esac
