#!/usr/bin/env bash

eval "$(xdotool getactivewindow getwindowgeometry --shell)"

regex="(^[[:alnum:]]*).*\b([[:digit:]]*)x([[:digit:]]*)\+([[:digit:]]*)\+([[:digit:]]*).*"

while read -r line; do
    if [[ $line =~ $regex ]]; then
        name="${BASH_REMATCH[1]}"
        width="${BASH_REMATCH[2]}"
        height="${BASH_REMATCH[3]}"
        xoff="${BASH_REMATCH[4]}"
        yoff="${BASH_REMATCH[5]}"

        if [ "${X}" -ge "$xoff" -a "${Y}" -ge "$yoff" -a "${X}" -lt "$(($xoff+$width))" -a "${Y}" -lt "$(($yoff+$height))" ]
        then
            monitor=$name
            break
        fi
    fi

done < <(xrandr | grep -w connected)

# If we found a monitor, echo it out, otherwise print an error.
if [ ! -z "$monitor" ]
then
    dunstify $monitor
    exit 0
else
    echo "Couldn't find any monitor for the current window." >&2
    exit 1
fi
