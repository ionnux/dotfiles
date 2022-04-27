#!/bin/bash

toggle="no"
while getopts :tfd opt; do
    case "${opt}" in
        t)  toggle="yes" ;;
        f)
            command="desktop -f"
            move="no"
            ;;
        d)
            command="node -d"
            move="yes"
            ;;
    esac
done

shift "$(($OPTIND -1))"

current_desktop="$(bspc query --desktops --desktop focused --names)"
if [[ $toggle == yes ]]; then
    if [[ $current_desktop == $1 ]]; then
        if [[ $move == yes ]]; then
            bspc node -d last.local -f
        else
            bspc desktop last -f
        fi
    else
        eval "bspc "$command" "$1" "$2""
    fi
else
    eval "bspc "$command" "$1" "$2""
fi

