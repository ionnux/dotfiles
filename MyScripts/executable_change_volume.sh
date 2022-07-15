#!/bin/bash

get_volume() {
    count=0
    volume_pos=0
    pactl list sinks | grep -Eo '\"bluetooth\"|\"pci\"|Volume: front-left: .* [[:digit:]]+%' | sed -E 's/Volume:.*\/[[:space:]]+//g; s/%.*//g; s/\"//g' | { while read -r line; do
            count=$(( count + 1 ))
            if [[ $line == bluetooth ]]; then
                volume_pos=$(( count - 1 ))
            fi
        done

        if [[ $volume_pos -eq 0 ]]; then volume_pos=1; fi

        count=0
        pactl list sinks | grep -Eo '\"bluetooth\"|\"pci\"|Volume: front-left: .* [[:digit:]]+%' | sed -E 's/Volume:.*\/[[:space:]]+//g; s/%.*//g; s/\"//g' | { while read -r line; do
                count=$(( count + 1 ))
                if [[ $count -eq $volume_pos ]]; then
                    volume=$line
                fi
            done
            echo $volume
        }
    }
}

while getopts :a:s:m:n opt
do

    # volume=$(pactl list sinks | grep -m1 Volume | awk -F '/' '{print $2}' | tr -d ' ' | tr -d '%')
    volume=$(get_volume)
    case "${opt}" in
        a) if [[ $volume -gt 100 ]]
            then
                volume=100
            else
                volume=$((volume + OPTARG))
            fi
            ;;

        s) if [[ $volume -gt 0 ]]; then
                volume=$((volume - OPTARG))
            fi
            ;;

        m) pactl set-sink-mute @DEFAULT_SINK@ toggle ;;

        n) notify='on' ;;

    esac

    # pactl set-sink-volume @DEFAULT_SINK@ ${volume}%
    amixer -D pulse sset Master ${volume}%
    mute=$(pactl list sinks | grep Mute | awk -F ' ' '{print $2}')

    if [[ $volume == 0 || "$mute" == "yes" ]]; then
        volume_icon="audio-volume-muted-symbolic"
    else
        if [ $volume -lt 30 ]; then
            volume_icon="audio-volume-low-symbolic"
        elif [ $volume -lt 70 ]; then
            volume_icon="audio-volume-medium-symbolic"
        elif [ $volume -le 100 ]; then
            volume_icon="audio-volume-high-symbolic"
        fi
    fi

    if [[ $notify == "on" ]]; then
        dunstify -h string:x-dunst-stack-tag:control "Volume" -h int:value:"$volume" -t 1500 --icon "$volume_icon"
    fi

done





