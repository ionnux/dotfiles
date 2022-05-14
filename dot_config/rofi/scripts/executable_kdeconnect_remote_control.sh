#!/usr/bin/bash
persistent_menu='yes'
source ~/MyScripts/rofi_font_size.sh
source ~/.config/dunst/scripts/remote_command_variables.sh
rofi_config='-sep "|" -dmenu -config ~/.config/rofi/dmenu.rasi -i'

show_device_menu() {
    # sed -i s/data_balance=.*/data_balance=""/ ~/.config/dunst/scripts/remote_command_variables.sh
    local selected_command="$(rofi -sep "|" -dmenu -config ~/.config/rofi/dmenu.rasi -theme-str "configuration {font: \"$font\";}" -i\
      -p "$1" <<< "Mobile Data $mobile_data|Bluetooth $bluetooth|Torch $torch|Open Link|Data Balance $data_balance")"

    if [[ $selected_command == Bluetooth* ]]; then
        kdeconnect-cli --ping-msg "Remote Command:$selected_command" --name "$1"
    elif [[ $selected_command == "Mobile Data"* ]]; then
        kdeconnect-cli --ping-msg "Remote Command:$selected_command" --name "$1"
    elif [[ $selected_command == Torch* ]]; then
        kdeconnect-cli --ping-msg "Remote Command:$selected_command" --name "$1"
    elif [[ $selected_command == "Data Balance"* ]]; then
        kdeconnect-cli --ping-msg "Remote Command:$selected_command" --name "$1"
    elif [[ $selected_command == "Open Link" ]]; then
        local clipboard="$(xclip -o)"
        local regex='^(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]\.[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]$'

        if [[ $clipboard =~ $regex ]]; then
            local link="$clipboard"
        else
            local link="$(eval "rofi $rofi_config -theme-str 'configuration { font: \"$font\"; }' -theme-str 'entry { placeholder: \"   Link...\"; }' -p 'Enter Link'")"
            if [[ ! $link =~ $regex ]]; then
                if [[ ! -z $link ]]; then local link="https://www.google.com/search?q=$link"; fi
            fi
        fi

        if [[ ! -z $link ]]; then kdeconnect-cli --ping-msg "Remote Command:${selected_command}:${link}" --name "$1"; fi
    fi

    if [[ ! -z $selected_command && $persistent_menu == yes ]]; then show_device_menu "$1"; fi
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

        local selected_device="$(rofi -sep "|" -dmenu -config ~/.config/rofi/dmenu.rasi -auto-select -theme-str "configuration {font: \"$font\";}" -i -p "Remote Command" <<< "${rofi_device_name}")"

        if [[ ! -z $selected_device ]]; then
            show_device_menu "$selected_device"
        fi
    }
}

kdeconnect-cli --refresh && show_available_devices
