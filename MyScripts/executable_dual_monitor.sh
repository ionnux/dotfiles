#!/bin/bash
secondary_resolution="1920x1200"
secondary_resolution_x="$( awk -F 'x' '{print $1}' <<< "$secondary_resolution")"
secondary_resolution_y="$( awk -F 'x' '{print $2}' <<< "$secondary_resolution")"
refresh_rate="60"
secondary_name="VIRTUAL1"
primary_name="$(xrandr --listactivemonitors | awk 'FNR == 2 {print $4}')"
primary_resolution_x=$(xrandr | grep $primary_name | grep -E -o '[[:digit:]]{4}x[[:digit:]]{4}' | awk -F 'x' '{print $1}')
primary_resolution_y=$(xrandr | grep $primary_name | grep -E -o '[[:digit:]]{4}x[[:digit:]]{4}' | awk -F 'x' '{print $2}')
secondary_position="--right-of $primary_name"


add_secondary_monitor() {
    xrandr_mode=$(gtf $secondary_resolution_x $secondary_resolution_y $refresh_rate | awk -F'Modeline ' 'FNR == 3 {print $2}')
    eval "xrandr --newmode $xrandr_mode"
    eval "xrandr --addmode "$secondary_name" "${secondary_resolution}_${refresh_rate}.00""
    eval "xrandr --output $secondary_name --mode "${secondary_resolution}_${refresh_rate}.00" $secondary_position"
    if ! pgrep -a polybar | grep VIRTUAL1; then
        ~/.config/polybar/launch.sh --blocks
    fi
    ~/.fehbg
}

remove_secondary_monitor() {
    eval "xrandr --output $secondary_name --off"
    eval "xrandr --delmode "$secondary_name" "${secondary_resolution}_${refresh_rate}.00""
    eval "xrandr --rmmode "${secondary_resolution}_${refresh_rate}.00""
    if pgrep -a polybar | grep VIRTUAL1; then
        ~/.config/polybar/launch.sh --blocks
    fi
    ~/.fehbg
}

start_vnc_server() {
    eval 'x11vnc -nocursorshape -nocursorpos -solid "#4c566a" -forever -rfbport 5901 -fs 0 -bg -noprimary -repeat -xdamage -display :0 -wireframe -clip ${secondary_resolution}+${primary_resolution_x}+0'
    pkill picom
    dunstify -h string:x-dunst-stack-tag:Vnc "Vnc" -h string:x-dunst-stack-tag:Vnc "server started"
}

stop_vnc_server() {
    pkill x11vnc
    dunstify -h string:x-dunst-stack-tag:Vnc "Vnc" -h string:x-dunst-stack-tag:Vnc "server stopped"
    if ! pgrep -a picom; then
        picom --experimental-backends &
    fi
}

start () {
    add_secondary_monitor
    if ! pgrep -a x11vnc; then
        start_vnc_server
    fi
}

stop () {
    stop_vnc_server
    remove_secondary_monitor
    # ~/.config/i3/i3Scripts/change_display_properties.sh -a
}

show_dmenu () {
    if pgrep -a x11vnc; then
        is_vnc_server_active="yes"
        vnc_server_option="Stop vnc server"
    else
        is_vnc_server_active="no"
        vnc_server_option="Start vnc server"
    fi

    if [[ "$(xrandr --listactivemonitors | grep Monitors | awk -F': ' '{print $2}')" -gt "1" ]]; then
        is_dual_monitor_active="yes"
        monitor_option="Remove secondary monitor"
    else
        is_dual_monitor_active="no"
        monitor_option="Add secondary monitor"
    fi

    if [[ "$is_dual_monitor_active" == "yes" ]] && [[ "$is_vnc_server_active" == "yes" ]]; then
        start_option="Stop dual monitor mode|"
    elif [[ "$is_dual_monitor_active" == "no" ]] && [[ "$is_vnc_server_active" == "no" ]]; then
        start_option="Launch dual monitor mode|"
    fi

    menu="$(rofi -sep "|" -dmenu -config ~/.config/rofi/dmenu.rasi -p "Dual Monitor" -i <<< "${start_option}Adb|$vnc_server_option|$monitor_option")"
    case "$menu" in
        'Launch dual monitor mode') start ;;
        'Stop dual monitor mode') stop ;;
        'Adb') adb reverse tcp:5901 tcp:5901 ;;
        'Stop vnc server') stop_vnc_server ;;
        'Start vnc server') start_vnc_server ;;
        'Add secondary monitor') add_secondary_monitor ;;
        'Remove secondary monitor') remove_secondary_monitor ;;
    esac
}

shift "$(($OPTIND -1))"
case $1 in
    'start') start ;;
    'stop') stop ;;
esac

while getopts ':r:h:s:p:m' opt; do
    case "$opt" in
        r)
            if [[ $OPTARG =~ ^[0-9]{4}x[0-9]{4}$ ]]; then
                secondary_resolution="$OPTARG"
            fi
            ;;
        h)
            if [[ $OPTARG =~ ^[0-9]{2,3}$ ]]; then
                refresh_rate="$OPTARG"
            fi
            ;;
        s) secondary_name="$OPTARG" ;;
        p) secondary_position="--${OPTARG}-of $primary_name" ;;
        m) show_dmenu ;;
        ?)
            echo "Usage: $(basename $0) [-a] [-b argument] [-c argument]"
            exit 1
            ;;
    esac
done