#!/usr/bin/env bash
PAIRING_DEVICE_NAME=""
PAIRING_DEVICE_ID=""
SELECTED_DEVICE_NAME=""
SELECTED_DEVICE_ID=""
HAS_PAIRING=false
DEVICE_NAMES=""


start () {
    counter=0
    for device in $(qdbus --literal org.kde.kdeconnect /modules/kdeconnect org.kde.kdeconnect.daemon.devices); do
        deviceid=$(echo "$device" | awk -F'["|"]' '{print $2}')
        devicename=$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid" org.kde.kdeconnect.device.name)
        isreach="$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid" org.kde.kdeconnect.device.isReachable)"
        istrust="$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid" org.kde.kdeconnect.device.isTrusted)"
        ischarging="$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid/battery" org.kde.kdeconnect.device.battery.isCharging)"

        check_pairing "$devicename" "$deviceid"
        add_device_name "$devicename" "$deviceid"
    done
    if [ $HAS_PAIRING = false ]; then
        show_devices
    else
        show_pair_action_menu "$PAIRING_DEVICE_NAME" "$PAIRING_DEVICE_ID"
    fi

}

add_device_name() {
    device_name="$1"
    is_paired=$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$2" org.kde.kdeconnect.device.isTrusted)

    if [ $is_paired = false ]; then
        devicename="$1 [ pair ]"
    fi

    if [ $counter -gt 0 ]; then
        DEVICE_NAMES="$DEVICE_NAMES|$devicename"
    else
        DEVICE_NAMES="$devicename"
    fi

    counter=$((counter + 1))
}

check_pairing() {
    has_pairing="$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$2" org.kde.kdeconnect.device.hasPairingRequests)"
    if [ "$has_pairing" = "true" ]; then
        HAS_PAIRING=true
        PAIRING_DEVICE_NAME="$1"
        PAIRING_DEVICE_ID="$2"
    fi
}

select_device (){
    for device in $(qdbus --literal org.kde.kdeconnect /modules/kdeconnect org.kde.kdeconnect.daemon.devices); do
        deviceid=$(echo "$device" | awk -F'["|"]' '{print $2}')
        devicename=$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid" org.kde.kdeconnect.device.name)
        isreach="$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid" org.kde.kdeconnect.device.isReachable)"
        istrust="$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid" org.kde.kdeconnect.device.isTrusted)"
        ischarging="$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid/battery" org.kde.kdeconnect.device.battery.isCharging)"

        if [ "$1" = "$devicename" ] || [ "$1" = "$devicename [ pair ]" ]; then
            SELECTED_DEVICE_ID="$deviceid"
            SELECTED_DEVICE_NAME="$devicename"
        fi
    done
}

show_device_list_menu () {
    menu="$(rofi -sep "|" -dmenu -config ~/.config/rofi/dmenu.rasi -i -p "$SELECTED_DEVICE_NAME" <<< "Ping|Find Device|Send File|Browse Files|Unpair")"
    case "$menu" in
        *'Ping') qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$SELECTED_DEVICE_ID/ping" org.kde.kdeconnect.device.ping.sendPing ;;
        *'Find Device') qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$SELECTED_DEVICE_ID/findmyphone" org.kde.kdeconnect.device.findmyphone.ring ;;
        *'Send File') qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$SELECTED_DEVICE_ID/share" org.kde.kdeconnect.device.share.shareUrl "file://$(zenity --file-selection)" ;;
        *'Browse Files')
            if [ "$(qdbus --literal org.kde.kdeconnect /modules/kdeconnect/devices/99c2205bc9b97222/sftp org.kde.kdeconnect.device.sftp.isMounted)" = "false" ]
            then
                qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$SELECTED_DEVICE_ID/sftp" org.kde.kdeconnect.device.sftp.mount
            fi
            delay 0.5
            i3-msg '[title="dropdown_vifm"] kill'
            ~/.local/kitty.app/bin/kitty --title dropdown_vifm ~/.config/vifm/scripts/vifmrun $(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$SELECTED_DEVICE_ID/sftp" org.kde.kdeconnect.device.sftp.mountPoint) ;;
        *'Unpair' ) qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$SELECTED_DEVICE_ID" org.kde.kdeconnect.device.unpair ;;
    esac
}


show_pair_action_menu () {
    menu="$(rofi -sep "|" -dmenu -config ~/.config/rofi/dmenu.rasi -i -p "$1 has sent a pairing request" <<< "Accept|Reject")"
    case "$menu" in
        *'Accept') qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$2" org.kde.kdeconnect.device.acceptPairing ;;
        *) qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$2" org.kde.kdeconnect.device.rejectPairing
    esac

}
request_pair() {
    qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$1" org.kde.kdeconnect.device.requestPair
}

show_devices () {
    menu="$(rofi -sep "|" -dmenu -config ~/.config/rofi/dmenu.rasi -i -p "kdeconnect" <<< "$DEVICE_NAMES")"
    case "$menu" in
        *)
            select_device "$menu"
            if [ "$SELECTED_DEVICE_ID" != "" ]; then
                if [[ $menu = *pair* ]]; then
                    request_pair "$SELECTED_DEVICE_ID"
                else
                    show_device_list_menu
                fi
            fi
            ;;
    esac
}

start
