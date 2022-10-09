#!/usr/bin/bash
sep="#"
connected_sign='connected'

rofi_connection_password () {
    local regex="(.*) \[(.*)\]"

    if [[ $1 =~ $regex ]]; then
        local device_name="${BASH_REMATCH[1]}"
        local wrong_password_error_message='Error: .* property is invalid'
        local password="$(rofi -password -sep $sep -dmenu -config ~/.config/rofi/dmenu.rasi -i -p "Enter password for \"${device_name}\"")"

        if [[ ! -z $password ]]; then
            local password_error=$(nmcli device wifi connect "$device_name" password "$password" 2>&1)
            if [[ $password_error =~ $wrong_password_error_message ]]; then
                dunstify -h string:x-dunst-stack-tag:network "Wifi" -h string:x-dunst-stack-tag:network "Incorrect password" --icon network-wireless-error-symbolic
                rofi_connection_password "$1"
            else
                dunstify -h string:x-dunst-stack-tag:network "Wifi" -h string:x-dunst-stack-tag:network "Connected to \"${device_name}\"" --icon network-wireless-error-symbolic
            fi
        else
            rofi_device_menu "$1" "device_list"
        fi
    fi
}

get_device_list() {
    local device_list
    local attributes
    local device_regex='(.*):(.*):(.*)'
    local counter=1

    nmcli device wifi rescan &&
    while read -r device; do
        if [[ $device =~ $device_regex ]]; then
            local connection_status="${BASH_REMATCH[1]}"
            local device_name="${BASH_REMATCH[2]}"
            local security="${BASH_REMATCH[3]}"

            if [[ -z $device_name ]]; then
                device_name=''
            else
                device_name="$device_name "
            fi

            if [[ -z $security ]]; then security="open"; fi

            if [[ $connection_status == yes ]]; then
                attributes="[$connected_sign|$security]"
            else
                attributes="[$security]"
            fi


            if [ $counter -gt 1 ]; then
                device_list="$device_list$sep$device_name$attributes"
            else
                device_list="$device_name$attributes"
            fi
            counter=$(( counter + 1 ))

        fi
    done <<< $(nmcli -f ACTIVE,SSID,SECURITY -t device wifi list)

    echo "$device_list"
}

get_connected_device() {
    raw_connected_device="$(nmcli -f TYPE,STATE,CONNECTION -t device status | grep  'wifi\:.*')"
    local connected_device
    local attributes
    local device_regex='(.*):(.*):(.*)'
    if [[ ! -z $raw_connected_device ]]; then
        if [[ $raw_connected_device =~ $device_regex ]]; then
            local connection_status="${BASH_REMATCH[2]}"
            local device_name="${BASH_REMATCH[3]}"

            if [[ $connection_status == connected ]]; then
                connected_device="$device_name [$connected_sign]"
            fi
        fi
    fi
    echo "$connected_device"
}

get_device_menu() {
    local regex="(.*) \[(.*)\]"

    if [[ $1 =~ $regex ]]; then
        local device_name="${BASH_REMATCH[1]}"
        local attributes="${BASH_REMATCH[2]}"

        local connect_menu
        local forget_menu

        if [[ ! -z $(nmcli -f name -t connection show | grep "$device_name") ]]; then
            forget_menu='forget'
        else
            forget_menu=''
        fi

        if [[ ! -z $(echo "$attributes" | grep 'connected') ]]; then
            connect_menu="disconnect"
        else
            connect_menu="connect"
        fi

        if [[ ! -z $forget_menu ]]; then
            echo "$connect_menu$sep$forget_menu"
        else
            echo "$connect_menu"
        fi
    fi

}

rofi_device_menu() {
    local regex="(.*) \[(.*)\]"

    if [[ $1 =~ $regex ]]; then
        local device_name="${BASH_REMATCH[1]}"
        local device_menu=$(get_device_menu "$1")
        local menu_items="$device_menu${sep}<"
        local selected_menu="$(rofi -sep $sep -dmenu -config ~/.config/rofi/dmenu.rasi  -i -p "$device_name" <<< "${menu_items}")"
        case $selected_menu in
            "<")
                if [[ $2 == "wifi_menu" ]]; then
                    rofi_wifi_menu
                elif [[ $2 == "device_list" ]]; then
                    rofi_device_list
                fi
                ;;
            'disconnect') nmcli device disconnect wlo1 ;;
            'connect')
                local regex="(.*) \[(.*)\]"
                local password_required_error_message='Error: .* Secrets were required, but not provided'
                local password_error=$(nmcli device wifi connect "$device_name")
                if [[ $password_error =~ $password_required_error_message ]]; then
                    rofi_connection_password "$1"
                else
                    dunstify -h string:x-dunst-stack-tag:network "Wifi" -h string:x-dunst-stack-tag:network "Connected to \"${device_name}\"" --icon network-wireless-error-symbolic
                fi
                ;;
            "forget")
                nmcli connection delete "$device_name"
                if [[ $2 == "wifi_menu" ]]; then
                    rofi_wifi_menu
                elif [[ $2 == "device_list" ]]; then
                    rofi_device_list
                fi
                if [[ $? == 0 ]]; then
                    dunstify -h string:x-dunst-stack-tag:network "Wifi" -h string:x-dunst-stack-tag:network "connection [${selected_option}] deleted" --icon network-wireless-symbolic
                fi
                ;;
        esac
    fi

}

rofi_device_list() {
    local devices="$(get_device_list)"
    local other_menu_items="rescan${sep}<"

    if [[ ! -z $devices ]]; then
        local menu_items="${devices}${sep}${other_menu_items}"
    else
        local menu_items=$other_menu_items
    fi

    local selected_menu="$(rofi -sep $sep -dmenu -config ~/.config/rofi/dmenu.rasi -i -p "available connections" <<< "${menu_items}")"


    case $selected_menu in
        '<') rofi_wifi_menu ;;
        'rescan') nmcli device wifi rescan && rofi_device_list ;;
        *) rofi_device_menu "$selected_menu" "device_list" ;;
    esac

}

get_saved_connections_list () {
    local saved_connections
    local connection_regex='(.*):.*wireless'
    local counter=1
    while read -r connection; do
        if [[ $connection =~ $connection_regex ]]; then
            local connection_name="${BASH_REMATCH[1]}"

            if [ $counter -gt 1 ]; then
                local saved_connections="$saved_connections$sep$connection_name"
            else
                local saved_connections="$connection_name"
            fi

            counter=$((counter + 1))
        fi
    done <<< $(nmcli -f name,type -t connection show | grep wireless)

    echo "$saved_connections"
}

rofi_delete_connection() {
    local connections="$(get_saved_connections_list)"
    local other_menu_items="<"

    if [[ ! -z $connections ]]; then
        local menu_items="${connections}${sep}${other_menu_items}"
    else
        local menu_items=$other_menu_items
    fi

    local selected_menu="$(rofi -sep $sep -dmenu -config ~/.config/rofi/dmenu.rasi -i -p "delete connections" <<< "${menu_items}")"
    case $selected_menu in
        '<') rofi_wifi_menu ;;
        *)
            if [[ ! -z $selected_menu ]]; then
                nmcli connection delete "$selected_menu"
                if [[ $? == 0 ]]; then
                    dunstify -h string:x-dunst-stack-tag:network "Wifi" -h string:x-dunst-stack-tag:network "connection [${selected_menu}] deleted" --icon network-wireless-symbolic
                fi
                rofi_delete_connection
            fi
            ;;
    esac
}

rofi_wifi_menu() {
    local enabled="$(nmcli radio wifi)"
    local connected_device="$(get_connected_device)"

    if [[ $enabled == enabled ]]; then
        local power_menu="power [on]"
    else
        local power_menu="power [off]"
    fi


    if [[ ! -z $connected_device ]]; then
        local connected_device_menu="${connected_device}${sep}"
    else
        local connected_device_menu=""
    fi

    local menu_items="${connected_device_menu}available connections${sep}delete connection${sep}connection manager${sep}${power_menu}"
    local selected_menu="$(rofi -sep $sep -dmenu -config ~/.config/rofi/dmenu.rasi -i -p "wifi" <<< "${menu_items}")"

    case $selected_menu in
        "$connected_device") rofi_device_menu "$selected_menu" "wifi_menu" ;;
        "available connections")
            if [[ $(nmcli radio wifi) == disabled ]]; then
                nmcli radio wifi on && rofi_device_list
            else
                rofi_device_list
            fi ;;
        "delete connection") rofi_delete_connection ;;
        'connection manager') nm-connection-editor & ;;
        'power [on]')
            nmcli radio wifi off &&
            dunstify -h string:x-dunst-stack-tag:network "Wifi" -h string:x-dunst-stack-tag:network "Disabled" --icon network-wireless-symbolic
            rofi_wifi_menu
            ;;
        'power [off]')
            nmcli radio wifi on &&
            dunstify -h string:x-dunst-stack-tag:network "Wifi" -h string:x-dunst-stack-tag:network "Enabled" --icon network-wireless-symbolic
            rofi_wifi_menu
            ;;
    esac
}

nmcli device wifi rescan
rofi_wifi_menu
