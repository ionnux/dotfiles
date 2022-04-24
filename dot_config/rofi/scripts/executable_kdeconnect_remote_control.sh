#!/usr/bin/bash
source ~/MyScripts/rofi_font_size.sh

show_device_menu() {
    local selected_command="$(rofi -sep "|" -dmenu -config ~/.config/rofi/dmenu.rasi -theme-str "configuration {font: \"$font\";}" -i -p "wifi" <<< "Bluetooth [Toggle]|Flash [Toggle]")"
    case "$selected_command" in
        'Bluetooth [Toggle]') kdeconnect-cli --ping-msg "$selected_command" --name "$1" ;;
        'Flash [Toggle]') kdeconnect-cli --ping-msg "$selected_command" --name "$1" ;;
    esac
}

show_available_devices() {
    local counter=1
    local regex="- (.*): .* \(paired and reachable\)"
    local rofi_device_name=""

    kdeconnect-cli --list-available | { while read device
        do
            if [[ $device =~ $regex ]]; then
                device_name="${BASH_REMATCH[1]}"

                if [ $counter -gt 1 ]; then
                    rofi_device_name="$rofi_device_name|$device_name"
                else
                    rofi_device_name="$device_name"
                fi
                counter=$(( counter + 1 ))

            fi
        done

        local selected_device="$(rofi -sep "|" -dmenu -config ~/.config/rofi/dmenu.rasi -auto-select -theme-str "configuration {font: \"$font\";}" -i -p "wifi" <<< "${rofi_device_name}")"

        if [[ ! -z $selected_device ]]; then
            show_device_menu "$selected_device"
        fi
    }
}

kdeconnect-cli --refresh && show_available_devices
