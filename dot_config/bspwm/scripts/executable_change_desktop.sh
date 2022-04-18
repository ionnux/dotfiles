#!/bin/bash

toggle="off"
while getopts :t opt; do
    case "${opt}" in
        t)  toggle="on" ;;
    esac
done

shift "$(($OPTIND -1))"
echo "toggle: $toggle"

if [[ $toggle == on ]]; then
    if [[ "$(bspc query --desktops --node focused --names)" == "$1" ]]; then
        bspc desktop last.local -f
    else
        bspc desktop -f "$1"
    fi
else
    bspc desktop -f "$1"
fi

