#!/usr/bin/env bash

pairing_device_name=""
pairing_device_id=""
selected_device_name=""
selected_device_id=""
has_pairing="false"
device_names=""

focused_output=$(bspc query --monitors -m focused --names)
if [ "$focused_output" = "eDP1" ]; then
    font="Iosevka 13"
else
    font="Iosevka 16"
fi

start () {
    counter=0
    for device in $(qdbus --literal org.kde.kdeconnect /modules/kdeconnect org.kde.kdeconnect.daemon.devices); do
        deviceid=$(echo "$device" | awk -F'["|"]' '{print $2}')
        devicename=$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid" org.kde.kdeconnect.device.name)

        check_pairing "$devicename" "$deviceid"
        add_device_name "$devicename" "$deviceid"
    done
    if [ "$has_pairing" = "false" ]; then
        if [ "$device_names" = "" ]; then #if there are no devices to show
            show_empty
        else
            show_devices
        fi
    else #if one of the device is asking to pair.
        show_pair_action_menu "$pairing_device_name" "$pairing_device_id"
    fi

}

add_device_name() {
    device_name="$1"
    is_paired=$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$2" org.kde.kdeconnect.device.isTrusted)
    is_reachable="$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$2" org.kde.kdeconnect.device.isReachable)"

    if [ $is_paired = false ]; then
        devicename="$1 [pair]"
    fi

    if [ $is_reachable = true ]; then
        if [ $counter -gt 0 ]; then
            device_names="$device_names|$devicename"
        else
            device_names="$devicename"
        fi

        counter=$((counter + 1))
    fi

}

check_pairing() {
    has_pairing="$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$2" org.kde.kdeconnect.device.hasPairingRequests)"
    if [ "$has_pairing" = "true" ]; then
        pairing_device_name="$1"
        pairing_device_id="$2"
    fi
}

select_device (){
    for device in $(qdbus --literal org.kde.kdeconnect /modules/kdeconnect org.kde.kdeconnect.daemon.devices); do
        deviceid=$(echo "$device" | awk -F'["|"]' '{print $2}')
        devicename=$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid" org.kde.kdeconnect.device.name)

        if [ "$1" = "$devicename" ] || [ "$1" = "$devicename [pair]" ]; then
            selected_device_id="$deviceid"
            selected_device_name="$devicename"
        fi
    done
}

show_device_list_menu () {
    menu="$(rofi -sep "|" -dmenu -config ~/.config/rofi/dmenu.rasi -i -theme-str "configuration {font: \"$font\";}" -p "$selected_device_name" <<< "Ping|Find Device|Send File|Browse Files|Unpair")"
    case "$menu" in
        *'Ping') qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$selected_device_id/ping" org.kde.kdeconnect.device.ping.sendPing ;;
        *'Find Device') qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$selected_device_id/findmyphone" org.kde.kdeconnect.device.findmyphone.ring ;;
        *'Send File') qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$selected_device_id/share" org.kde.kdeconnect.device.share.shareUrl "file://$(zenity --file-selection)" ;;
        *'Browse Files')
            if [ "$(qdbus --literal org.kde.kdeconnect /modules/kdeconnect/devices/99c2205bc9b97222/sftp org.kde.kdeconnect.device.sftp.isMounted)" = "false" ]
            then
                qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$selected_device_id/sftp" org.kde.kdeconnect.device.sftp.mount
            fi
            sleep 0.5
            i3-msg '[title="dropdown_vifm"] kill'
            ~/.local/kitty.app/bin/kitty --title dropdown_vifm ~/.config/vifm/scripts/vifmrun $(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$selected_device_id/sftp" org.kde.kdeconnect.device.sftp.mountPoint) ;;
        *'Unpair' ) qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$selected_device_id" org.kde.kdeconnect.device.unpair ;;
    esac
}


show_pair_action_menu () {
    menu="$(rofi -sep "|" -dmenu -config ~/.config/rofi/dmenu.rasi -theme-str "configuration {font: \"$font\";}" -i -p "$1 has sent a pairing request" <<< "Accept|Reject")"
    case "$menu" in
        *'Accept') qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$2" org.kde.kdeconnect.device.acceptPairing ;;
        *) qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$2" org.kde.kdeconnect.device.rejectPairing
    esac

}
request_pair() {
    qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$1" org.kde.kdeconnect.device.requestPair
}

show_devices () {
    if ! [[ "$device_names" == *\|* ]]; then
        if [[ "$device_names" == *pair* ]]; then
            auto_select=""
        else
            auto_select="-auto-select"
        fi
    fi

    menu="$(rofi -sep "|" "$auto_select" -dmenu -config ~/.config/rofi/dmenu.rasi -theme-str "configuration {font: \"$font\";}" -i -p "kdeconnect" <<< "$device_names")"
    case "$menu" in
        *)
            select_device "$menu"
            if [ "$selected_device_id" != "" ]; then
                if [[ $menu = *pair* ]]; then
                    request_pair "$selected_device_id"
                else
                    show_device_list_menu
                fi
            fi
            ;;
    esac
}

show_empty () {
    menu="$(rofi -sep "|" -dmenu -config ~/.config/rofi/dmenu.rasi -theme-str "configuration {font: \"$font\";}" -i -p "kdeconnect" <<< "No device connected.")"
}

start
