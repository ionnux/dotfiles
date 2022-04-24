#!/bin/bash
source ~/MyScripts/rofi_font_size.sh

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

    if ! pgrep -f -a "polybar -q secondary"; then
       polybar -r -q secondary -c "~/.config/polybar/custom/config.ini" &
    fi

    if ! pgrep -f -a "polybar -q primary"; then
        polybar -r -q primary -c "~/.config/polybar/custom/config.ini" &
    fi

    ~/.fehbg
}

remove_secondary_monitor() {
    eval "xrandr --output $secondary_name --off"
    eval "xrandr --delmode "$secondary_name" "${secondary_resolution}_${refresh_rate}.00""
    eval "xrandr --rmmode "${secondary_resolution}_${refresh_rate}.00""

    if pgrep -f -a "polybar -q secondary"; then
        pkill --signal=9 -f "polybar -q secondary"
    fi

    if ! pgrep -f -a "polybar -q primary"; then
        polybar -r -q primary -c "~/.config/polybar/custom/config.ini" &
    fi

    ~/.fehbg
    # ~/.config/i3/i3Scripts/change_display_properties.sh -a
}

start_vnc_server() {
    eval 'x11vnc -nocursorshape -nocursorpos -solid "#4c566a" -forever -rfbport 5901 -fs 0 -bg -noprimary -repeat -xdamage -display :0 -wireframe -clip ${secondary_resolution}+${primary_resolution_x}+0'
    pkill --signal=9 picom
    dunstify -h string:x-dunst-stack-tag:Vnc "Vnc" -h string:x-dunst-stack-tag:Vnc "server started"

    # reload bspwm config
    bspc wm -r
}

stop_vnc_server() {
    pkill --signal=9 x11vnc
    dunstify -h string:x-dunst-stack-tag:Vnc "Vnc" -h string:x-dunst-stack-tag:Vnc "server stopped"
    if ! pgrep -a picom; then
        picom --experimental-backends &
    fi

    # reload bspwm config
    bspc wm -r
}

start () {
    add_secondary_monitor
    sleep 0.2
    if ! pgrep -a x11vnc; then
        start_vnc_server
    fi
}

stop () {
    stop_vnc_server
    sleep 0.2
    remove_secondary_monitor
}

show_menu () {
    if [[ -z $(pgrep -a x11vnc) ]]; then
        is_vnc_server_active="no"
        vnc_server_option="Start vnc server"
    else
        is_vnc_server_active="yes"
        vnc_server_option="Stop vnc server"
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

    menu="$(rofi -sep "|" -dmenu -config ~/.config/rofi/dmenu.rasi -theme-str "configuration {font: \"$font\";}" -p "Dual Monitor" -i <<< "${start_option}Adb|$vnc_server_option|$monitor_option")"
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

while getopts ':r:h:s:p:' opt; do
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
    esac
done

show_menu
