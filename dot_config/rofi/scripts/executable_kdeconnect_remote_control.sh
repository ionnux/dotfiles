#!/usr/bin/bash
source ~/MyScripts/rofi_font_size.sh
source ~/MyScripts/tasker_variables.sh
rofi_config='-sep "|" -dmenu -config ~/.config/rofi/dmenu.rasi -i'

show_device_menu() {
    local selected_command="$(rofi -sep "|" -dmenu -config ~/.config/rofi/dmenu.rasi -theme-str "configuration {font: \"$font\";}" -i\
      -p "Kdeconnect Remote Command" <<< "Mobile Data [$mobile_data]|Bluetooth [$bluetooth]|Flash [$flash]|Open Link")"

    if [[ $selected_command == Bluetooth* ]]; then
        kdeconnect-cli --ping-msg "Remote Command:$selected_command" --name "$1"
    elif [[ $selected_command == "Mobile Data"* ]]; then
        kdeconnect-cli --ping-msg "Remote Command:$selected_command" --name "$1"
    elif [[ $selected_command == Flash* ]]; then
        kdeconnect-cli --ping-msg "Remote Command:$selected_command" --name "$1"
    elif [[ $selected_command == "Open Link" ]]; then
        local clipboard="$(xclip -o)"
        local regex='^(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]\.[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]$'
        if [[ $clipboard =~ $regex ]]; then
            local link="$clipboard"
        else
            local input="$(eval "rofi $rofi_config -theme-str 'configuration { font: \"$font\"; }' -theme-str 'entry { placeholder: \"   Link...\"; }' -p 'Enter Link'")"
            if [[ $input =~ $regex ]]; then
                local link="$input"
            else
                if [[ ! -z $input ]]; then local link="https://www.google.com/search?q=$input"; fi
            fi
        fi

        if [[ ! -z $link ]]; then kdeconnect-cli --ping-msg "Remote Command:${selected_command}:${link}" --name "$1"; fi
    fi
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
