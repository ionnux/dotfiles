#!/usr/bin/bash
show_menu() {
    menu_items="wifi|bluetooth|multi monitor|kdeconnect|mtp|scrcpy"
    local selected_menu="$(rofi -sep '|' -dmenu -config ~/.config/rofi/dmenu.rasi -i -p "rofi menus" <<< "${menu_items}")"
    case $selected_menu in
        "wifi") ~/.config/rofi/scripts/wifi.sh ;;
        "bluetooth") ~/.config/rofi/scripts/bluetooth.sh ;;
        "multi monitor") ~/.config/rofi/scripts/dual_monitor.sh ;;
        "kdeconnect") ~/.config/rofi/scripts/kdeconnect.sh ;;
        "mtp") ~/.config/rofi/scripts/mtp.sh ;;
        "scrcpy") ~/.config/rofi/scripts/scrcpy/scrcpy.sh ;;
    esac
}

show_menu
