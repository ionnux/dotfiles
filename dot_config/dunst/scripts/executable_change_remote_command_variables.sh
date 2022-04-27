#!/bin/bash

regex="Remote Command: (.*) \[(.*)\]"

if [[ $DUNST_BODY =~ $regex ]]; then
    variable_name="${BASH_REMATCH[1]}"
    variable_value="${BASH_REMATCH[2]}"

    case "$variable_name" in
        'Bluetooth') eval 'sed -i 's/bluetooth=.*/bluetooth="${variable_value}"/' ~/.config/dunst/scripts/remote_command_variables.sh' ;;
        'Mobile Data') eval 'sed -i 's/mobile_data=.*/mobile_data="${variable_value}"/' ~/.config/dunst/scripts/remote_command_variables.sh' ;;
        'Torch') eval 'sed -i 's/torch=.*/torch="${variable_value}"/' ~/.config/dunst/scripts/remote_command_variables.sh' ;;
    esac
fi

if pgrep -af kdeconnect_remote_control.sh; then
  pkill --signal=9 rofi && ~/.config/rofi/scripts/kdeconnect_remote_control.sh
fi

