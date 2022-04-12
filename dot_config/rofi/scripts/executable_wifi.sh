#!/usr/bin/bash

CONNECTED_NETWORK=""
NETWORK_NAMES=""
NETWORK_DISPLAY_NAMES=""
error_message="Error: Connection activation failed: (7) Secrets were required, but not provided."



add_network_name() {
    name="$1"

    if [ "$CONNECTED_NETWORK" = "$name" ]; then
        name="$1 [connected]"
    fi

    if [ $counter -gt 0 ]; then
        NETWORK_NAMES="$NETWORK_NAMES\n$1"
        NETWORK_DISPLAY_NAMES="$NETWORK_DISPLAY_NAMES|$name"
    else
        NETWORK_NAMES="$1"
        NETWORK_DISPLAY_NAMES="$name"
    fi

    counter=$((counter + 1))

}

show_available_networks () {
    counter=0
    nmcli -f ACTIVE,SSID -t device wifi list | { while IFS= read -r line; do
            if ! echo $line | grep -q "SSID"; then
                if [ "$(echo "$line" | awk -F: '{print $1}')" = "yes" ]; then
                    name=$(echo "$line" | awk -F: '{print $2}')
                    CONNECTED_NETWORK="$name"
                    add_network_name "$name"
                else
                    name=$(echo "$line" | awk -F: '{print $2}')
                    add_network_name "$name"
                fi
            fi
        done

        if [ "$NETWORK_DISPLAY_NAMES" = "" ]; then
            show_empty
        else
            menu="$(rofi -sep "|" -dmenu -config ~/.config/rofi/dmenu.rasi -theme-str "configuration {font: \"$font\";}" -i -p "Select Network" <<< "$NETWORK_DISPLAY_NAMES|Rescan")"
            case "$menu" in
                'Rescan')
                    nmcli device wifi rescan
                    sleep 0.5
                    show_available_networks
                    ;;
                *)
                    if [ "$menu" != "" ]; then
                        if [[ $menu = $CONNECTED_NETWORK*connected* ]]; then
                            nmcli device disconnect wlo1
                        else
                            prompt=$(nmcli device wifi connect "$menu")
                            if [[ "$prompt" == "$error_message" ]]; then
                                show_password_prompt "$menu"
                            fi
                        fi
                    fi
                    ;;
            esac
        fi
    }
}
show_password_prompt () {
    password="$(rofi -password -sep "|" -dmenu -config ~/.config/rofi/dmenu.rasi -i -theme-str "configuration { font: \"$font\"; }" -theme-str 'entry { placeholder: "   Password..."; }' -p "Enter password")"
    case "$password" in
        *) nmcli device wifi connect "$1" password $password ;;
    esac
}

show_wifi_menu () {
    focused_output=$(bspc query --monitors -m focused --names)
    if [ "$focused_output" = "eDP1" ]; then
        font="Iosevka 12"
    else
        font="Iosevka 16"
    fi

    menu=""
    if wifi | grep -q "= on"; then
        menu="$(rofi -sep "|" -dmenu -config ~/.config/rofi/dmenu.rasi -theme-str "configuration { font: \"$font\"; }" -i -p "wifi" <<< "Select Network|Turn Off")"
    else
        menu="$(rofi -sep "|" -dmenu -config ~/.config/rofi/dmenu.rasi -theme-str "configuration { font: \"$font\"; }" -i -p "wifi" <<< "turn on")"
    fi
    case "$menu" in
        'Select Network') show_available_networks ;;
        'turn on') nmcli radio wifi on ;;
        'Turn Off') nmcli radio wifi off ;;
    esac
}

show_empty () {
    menu="$(rofi -sep "|" -dmenu -config ~/.config/rofi/dmenu.rasi -theme-str "configuration { font: \"$font\"; }" -theme-str ' horibox { children: [ prompt, listview ]; margin: 0px 830px 0px 830px; } prompt { margin: 0px 10px 0px 0px;}' -p "No wifi availbale" -i <<< "Rescan")"
    case "$menu" in
        'Rescan')
            nmcli device wifi rescan
            sleep 0.5
            show_available_networks
            ;;
    esac
}

show_wifi_menu
