#!/usr/bin/bash
declare -A devices_array
scanning="no"
paired_sign='+'
unpaired_sign='?'
connected_sign='#'
trusted_sign='!'
sep="|"

populate_devices_array() {
    device_regex='Device (..:..:..:..:..:..) (.*)'
    while read -r device; do
        if [[ $device =~ $device_regex ]]; then
            device_id="${BASH_REMATCH[1]}"
            device_name="${BASH_REMATCH[2]}"
            devices_array[$device_name]=$device_id
        fi
    done <<< $(bluetoothctl devices)
}

get_device_attributes() {
    local device_id="$1"
    local device_attributes

    local paired="$(bluetoothctl info "$device_id" | grep "Paired" | awk -F ': ' '{print $2}')"
    local connected="$(bluetoothctl info "$device_id" | grep "Connected" | awk -F ': ' '{print $2}')"
    local trusted="$(bluetoothctl info "$device_id" | grep "Trusted" | awk -F ': ' '{print $2}')"

    if [[ $paired == yes ]]; then
        device_attributes="$device_attributes$paired_sign"
    else
        device_attributes="$device_attributes$unpaired_sign"
    fi
    if [[ $connected == yes ]]; then device_attributes="$device_attributes$connected_sign"; fi
    if [[ $trusted == yes ]]; then device_attributes="$device_attributes$trusted_sign"; fi

    echo "$device_attributes"
}

get_device_menu() {
    local device_id="$1"
    local pair_menu
    local connect_menu
    local trust_menu
    local blocked_menu

    local paired="$(bluetoothctl info "$device_id" | grep "Paired" | awk -F ': ' '{print $2}')"
    local connected="$(bluetoothctl info "$device_id" | grep "Connected" | awk -F ': ' '{print $2}')"
    local trusted="$(bluetoothctl info "$device_id" | grep "Trusted" | awk -F ': ' '{print $2}')"
    local blocked="$(bluetoothctl info "$device_id" | grep "Blocked" | awk -F ': ' '{print $2}')"

    if [[ $paired == yes ]]; then
        pair_menu='unpair'
    else
        pair_menu='pair'
    fi

    if [[ $trusted == yes ]]; then
        trust_menu='untrust'
    else
        trust_menu='trust'
    fi

    if [[ $connected == yes ]]; then
        connect_menu='disconnect'
    else
        connect_menu='connect'
    fi

    if [[ $blocked == yes ]]; then
        blocked_menu='unblock'
    else
        blocked_menu='block'
    fi

    echo "$connect_menu$sep$pair_menu$sep$trust_menu$sep$blocked_menu"
}

get_device_list() {
    local -n array=$2
    local counter=1
    local device_list


    for device_name in "${!array[@]}"; do
        local device_id="${array[$device_name]}"
        local device_attributes="$(get_device_attributes $device_id)"

        if [ $counter -gt 1 ]; then
            device_list="$device_list$sep$device_name [$device_attributes]"
        else
            device_list="$device_name [$device_attributes]"
        fi
        counter=$(( counter + 1 ))
    done

    echo "$device_list"
}

rofi_device_menu() {
    local regex="(.*) \[(.*)\]"

    if [[ $1 =~ $regex ]]; then
        local device_name="${BASH_REMATCH[1]}"
        local device_attributes="${BASH_REMATCH[2]}"
        local device_id="${devices_array[$device_name]}"
    fi

    local device_menu=$(get_device_menu $device_id)
    local menu_items="$device_menu${sep}<"
    local selected_menu="$(rofi -sep $sep -dmenu -config ~/.config/rofi/dmenu.rasi  -i -p "$device_name" <<< "${menu_items}")"

    case $selected_menu in
        "disconnect") bluetoothctl disconnect $device_id && rofi_device_menu "$1" ;;
        "connect")
            local powered="$(bluetoothctl show | grep "Powered:" | awk -F ': ' '{print $2}')"
            if [[ $powered == no ]]; then
                bluetoothctl power on && bluetoothctl connect $device_id && rofi_device_menu "$1"
            else
                bluetoothctl connect $device_id && rofi_device_menu "$1"
            fi
            ;;
        "pair") bluetoothctl pairable on && bluetoothctl pair $device_id && rofi_device_menu "$1" ;;
        "unpair") bluetoothctl remove $device_id && rofi_device_list ;;
        "trust") bluetoothctl trust $device_id && rofi_device_menu "$1" ;;
        "untrust") bluetoothctl untrust $device_id && rofi_device_menu "$1" ;;
        "block") bluetoothctl block $device_id && rofi_device_menu "$1" ;;
        "unblock") bluetoothctl unblock $device_id && rofi_device_menu "$1" ;;
        "<") rofi_device_list ;;
    esac
}

rofi_device_list() {
    populate_devices_array
    local in_devices_list="yes"
    local devices=$(get_device_list $sep devices_array)
    local other_menu_items="refresh${sep}scan${sep}<"

    if [[ ! -z $devices ]]; then
        local menu_items="${devices}${sep}${other_menu_items}"
    else
        local menu_items=$other_menu_items
    fi

    local selected_menu="$(rofi -sep $sep -dmenu -config ~/.config/rofi/dmenu.rasi -i -p "bluetooth devices" <<< "${menu_items}")"

    case $selected_menu in
        "refresh") rofi_device_list  ;;
        "scan")
            bluetoothctl --timeout 60 scan on &
            rofi_device_list
            ;;
        "<") rofi_bluetooth_menu ;;
        *) if [[ ! -z $selected_menu ]]; then rofi_device_menu "$selected_menu"; fi ;;
    esac
    in_devices_list="no"
}


rofi_bluetooth_menu() {
    local powered="$(bluetoothctl show | grep "Powered:" | awk -F ': ' '{print $2}')"
    local pairable="$(bluetoothctl show | grep "Pairable:" | awk -F ': ' '{print $2}')"
    local discoverable="$(bluetoothctl show | grep "Discoverable:" | awk -F ': ' '{print $2}')"

    if [[ $powered == yes ]]; then
        local powered_menu="powered [yes]"
    else
        local powered_menu="powered [no]"
    fi

    if [[ $pairable == yes ]]; then
        local pairable_menu="pairable [yes]"
    else
        local pairable_menu="pairable [no]"
    fi

    if [[ $discoverable == yes ]]; then
        local discoverable_menu="discoverable [yes]"
    else
        local discoverable_menu="discoverable [no]"
    fi

    local menu_items="devices${sep}${powered_menu}${sep}${pairable_menu}${sep}${discoverable_menu}"
    local selected_menu="$(rofi -sep $sep -dmenu -config ~/.config/rofi/dmenu.rasi -i -p "bluetooth" <<< "${menu_items}")"

    case $selected_menu in
        "devices") rofi_device_list ;;
        "powered [yes]") bluetoothctl power off && rofi_bluetooth_menu ;;
        "powered [no]") bluetoothctl power on && rofi_bluetooth_menu ;;
        "pairable [yes]") bluetoothctl pairable off && rofi_bluetooth_menu ;;
        "pairable [no]") bluetoothctl pairable on && rofi_bluetooth_menu ;;
        "discoverable [yes]") bluetoothctl discoverable off && rofi_bluetooth_menu ;;
        "discoverable [no]") bluetoothctl discoverable on && rofi_bluetooth_menu ;;
    esac
}

rofi_bluetooth_menu
pkill --signal=9 bluetoothctl
