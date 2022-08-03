#!/usr/bin/bash
source ~/MyScripts/rofi_font_size.sh

network_display_names=""

add_network_name() {
    if [ $2 -gt 0 ]; then
        network_display_names="$network_display_names|$1"
    else
        network_display_names="$1"
    fi
}

connect_using_password () {
    local wrong_password_error_message='Error: .* property is invalid'
    local password="$(rofi -password -sep "|" -dmenu -config ~/.config/rofi/dmenu.rasi -i\
      -theme-str 'entry { placeholder: "   Password..."; }' -p "Enter password")"

    if [[ ! -z $password ]]; then
        local password_error=$(nmcli device wifi connect "$1" password "$password" 2>&1)
        if [[ $password_error =~ $wrong_password_error_message ]]; then
            dunstify -h string:x-dunst-stack-tag:network "Wifi" -h string:x-dunst-stack-tag:network "Incorrect password" --icon network-wireless-error-symbolic
            connect_using_password "$1"
        fi
    fi
}

delete_wifi_connection () {
    local counter=0
    nmcli -f name,type -t connection show | grep wireless | { while IFS= read -r connection; do
            local connection_name=$(echo "$connection" | awk -F: '{print $1}' )
            if [ $counter -gt 0 ]; then
                saved_connections="$saved_connections|$connection_name"
            else
                saved_connections="$connection_name"
            fi
            counter=$((counter + 1))
        done
        local selected_option=$(rofi -sep "|" -dmenu -config ~/.config/rofi/dmenu.rasi\
          -i -p "Delete Connection" <<< "${saved_connections}|<")
        case $selected_option in
            '<') show_wifi_menu ;;
            *)
                if [[ ! -z $selected_option ]]; then
                    nmcli connection delete "$selected_option"
                    if [[ $? == 0 ]]; then
                        dunstify -h string:x-dunst-stack-tag:network "Wifi" -h string:x-dunst-stack-tag:network "connection [${selected_option}] deleted" --icon network-wireless-symbolic
                    fi
                    # delete_wifi_connection
                fi
                ;;
        esac
    }
}

show_wifi_menu () {
  if [[ $(nmcli radio wifi) == "enabled" ]]; then
        local counter=0
        nmcli -f ACTIVE,SSID,SECURITY -t device wifi list | { while IFS= read -r line; do
                if [ "$(echo "$line" | awk -F: '{print $1}')" = "yes" ]; then
                    local connected_network=$(echo "$line" | awk -F: '{print $2}')
                    add_network_name "$connected_network [connected]" "$counter"
                else
                    local connection_name=$(echo "$line" | awk -F: '{print $2}')
                    local security=$(echo "$line" | awk -F: '{print $3}')
                    add_network_name "${connection_name} [$security]" "$counter"
                fi
                counter=$((counter + 1))
            done

            if [[ ! -z $network_display_names ]]; then
                network_display_names="${network_display_names}|"
            fi

            local selected_option="$(rofi -sep "|" -dmenu -config ~/.config/rofi/dmenu.rasi\
              -p "wifi" <<< "${network_display_names}Rescan|Delete Connection|Connection Manager|Turn Off")"

            case "$selected_option" in
                'Rescan') nmcli device wifi rescan && show_wifi_menu ;;
                'Delete Connection') delete_wifi_connection ;;
                'Connection Manager') nm-connection-editor & ;;
                'Turn Off')
                    dunstify -h string:x-dunst-stack-tag:network "Wifi" -h string:x-dunst-stack-tag:network "Disabled" --icon network-wireless-symbolic
                    nmcli radio wifi off
                    ;;
                *)
                    local regex="(.*) \[(.*)\]"
                    if [[ $selected_option =~ $regex ]]; then
                        local connection_name="${BASH_REMATCH[1]}"
                        local connection_info="${BASH_REMATCH[2]}"

                        case "$connection_info" in
                            'connected') nmcli device disconnect wlo1 ;;
                            *)
                                local password_required_error_message='Error: .* Secrets were required, but not provided'
                                local password_error=$(nmcli device wifi connect "$connection_name")
                                if [[ $password_error =~ $password_required_error_message ]]; then
                                    connect_using_password "$connection_name"
                                fi
                                ;;
                        esac
                    fi
                    ;;
            esac
        }
    else
        local selected_option="$(rofi -sep "|" -dmenu -config ~/.config/rofi/dmenu.rasi\
          -i -p "wifi" <<< "Connection Manager|Delete Connection|Turn On")"
        case "$selected_option" in
            'Delete Connection') delete_wifi_connection ;;
            'Connection Manager') nm-connection-editor & ;;
            'Turn On')
                dunstify -h string:x-dunst-stack-tag:network "Wifi" -h string:x-dunst-stack-tag:network "Enabled" --icon network-wireless-symbolic
                nmcli radio wifi on && show_wifi_menu
                ;;
        esac
    fi
}

show_wifi_menu
