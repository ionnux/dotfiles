#!/usr/bin/bash

# declare -A devices_array
config_file="/home/og_saaz/.config/rofi/scripts/scrcpy/scrcpy.conf"
sep=":"
set device_list

get_opposite(){
    case $1 in
        "yes") echo "no" ;;
        "no") echo "yes" ;;
    esac
}

get_current_option() {
    local regex='.*\[(.*)]'
    if [[ $1 =~ $regex ]]; then echo "${BASH_REMATCH[1]}"; fi
}

add_missing_config() {
    source $config_file
    if [[ -z $turn_screen_off ]]; then echo 'turn_screen_off="yes"' >> $config_file; fi
    if [[ -z $print_fps ]]; then echo 'print_fps="no"' >> $config_file; fi
    if [[ -z $bitrate ]]; then echo 'bitrate=16' >> $config_file; fi
    if [[ -z $max_size ]]; then echo 'max_size="default"' >> $config_file; fi
    if [[ -z $max_fps ]]; then echo 'max_fps=60' >> $config_file; fi
    if [[ -z $display_buffer ]]; then echo 'display_buffer="50"' >> $config_file; fi
    if [[ -z $lock_orientation ]]; then echo 'lock_orientation="no"' >> $config_file; fi
    if [[ -z $rotation ]]; then echo 'rotation="no"' >> $config_file; fi
    if [[ -z $no_control ]]; then echo 'no_control="no"' >> $config_file; fi
    if [[ -z $stay_awake ]]; then echo 'stay_awake="yes"' >> $config_file; fi
    if [[ -z $hid_keyboard ]]; then echo 'hid_keyboard="yes"' >> $config_file; fi
    if [[ -z $hid_mouse ]]; then echo 'hid_mouse="yes"' >> $config_file; fi
    if [[ -z $otg ]]; then echo 'otg="no"' >> $config_file; fi
    if [[ -z $power_off_on_close ]]; then echo 'power_off_on_close="yes"' >> $config_file; fi
    source $config_file
}

unset_config_variables() {
    unset turn_screen_off
    unset print_fps
    unset bitrate
    unset max_size
    unset max_fps
    unset display_buffer
    unset lock_orientation
    unset rotation
    unset no_control
    unset stay_awake
    unset hid_keyboard
    unset hid_mouse
    unset otg
    unset power_off_on_close
}

if [[ ! -f $config_file ]]; then
    unset_config_variables
    touch $config_file
    add_missing_config
fi

set_device_list() {
    local device_regex='([^[:space:]]+).*:.*:(.*) device.*'
    while read -r device; do
        if [[ $device =~ $device_regex ]]; then
            local serial="${BASH_REMATCH[1]}"
            local name="${BASH_REMATCH[2]}"

            # adb -s $serial tcpip 5555 &

            local wireless_serial='.*\..*\..*\..*:.*'
            local connection_type
            if [[ $serial =~ $wireless_serial ]]; then
                connection_type="wireless"
            else
                connection_type="wired"
            fi
            local attribute
            if [[ -z $(pgrep -fla "scrcpy -s $serial") ]]; then
                attribute="$connection_type"
            else
                attribute="$connection_type|running"
            fi
            local id="$name [$attribute]"
            devices_array[$id]=$serial
        fi
    done <<< $(adb devices -l)

    local counter=1
    for device_id in "${!devices_array[@]}"; do
        local serial="${devices_array[$device_id]}"

        if [ $counter -gt 1 ]; then
            device_list="$device_list$sep$device_id"
        else
            device_list="$device_id"
        fi
        counter=$(( counter + 1 ))
    done
}

launch_scrcpy() {
    local parsed_config=$(parse_config)
    eval "scrcpy -s $1 $parsed_config"
}

rofi_device_menu() {
    local regex="(.*) \[(.*)\]"
    if [[ $1 =~ $regex ]]; then
        local device_name="${BASH_REMATCH[1]}"
        local attribute="${BASH_REMATCH[2]}"
        local device_serial="${devices_array[$1]}"

        local connection_menu
        if [[ $attribute == wired* ]]; then
            if [[ ! -v "devices_array[$device_name [wireless]]" ]]; then
                connection_menu="add wireless connection"
            else
                unset connection_menu
            fi
        else
            connection_menu="remove wireless connection"
        fi

        local launch_menu
        if [[ $attribute == *running* ]]; then
            launch_menu="stop${sep}rerun"
        else
            launch_menu="launch"
        fi

        local other_menu_items="<"
        if [[ -z $connection_menu ]]; then
            local menu_items="${launch_menu}${sep}${other_menu_items}"
        else
            local menu_items="${launch_menu}${sep}${connection_menu}${sep}${other_menu_items}"
        fi

        local selected_menu="$(rofi -sep $sep -dmenu -config ~/.config/rofi/dmenu.rasi -i -p "$device_name" <<< "${menu_items}")"

        case $selected_menu in
            "add wireless connection")
                local ip="$(adb -s $device_serial shell ip route | awk '{print $9}')"
                # eval "adb connect ${ip}:5555"
                eval "adb connect ${ip}"
                rofi_scrcpy_menu
                ;;
            "remove wireless connection")
                eval "adb disconnect $device_serial"
                rofi_scrcpy_menu
                ;;
            "launch") launch_scrcpy $device_serial ;;
            "stop")
                pkill --signal=9 -f "scrcpy -s $device_serial"
                ;;
            "rerun")
                pkill --signal=9 -f "scrcpy -s $device_serial"
                launch_scrcpy $device_serial
                ;;
            "<") rofi_scrcpy_menu ;;
        esac
    fi
}

parse_config() {
    add_missing_config
    local parsed_config=""

    if [[ $turn_screen_off == yes ]];      then parsed_config="${parsed_config} --turn-screen-off"                 ; fi
    if [[ $print_fps == yes ]];            then parsed_config="${parsed_config} --print-fps"                       ; fi
    if [[ $otg == yes ]];                  then parsed_config="${parsed_config} --otg --window-title 'scrcpy otg'" ; fi
    if [[ $no_control == yes ]];           then parsed_config="${parsed_config} --no-control"                      ; fi
    if [[ $stay_awake == yes ]];           then parsed_config="${parsed_config} --stay-awake"                      ; fi
    if [[ $hid_mouse == yes ]];            then parsed_config="${parsed_config} --hid-mouse"                       ; fi
    if [[ $hid_keyboard == yes ]];         then parsed_config="${parsed_config} --hid-keyboard"                    ; fi
    if [[ $power_off_on_close == yes ]];   then parsed_config="${parsed_config} --power-off-on-close"              ; fi
    if [[ ! $bitrate == default ]];        then parsed_config="${parsed_config} --bit-rate ${bitrate}M"            ; fi
    if [[ ! $display_buffer == default ]]; then parsed_config="${parsed_config} --display-buffer=${display_buffer}"; fi
    if [[ ! $max_size == default ]];       then parsed_config="${parsed_config} --max-size ${max_size}"            ; fi
    if [[ ! $max_fps == default ]];        then parsed_config="${parsed_config} --max-fps ${max_fps}"              ; fi
    case $lock_orientation in
        "current") parsed_config="${parsed_config} --lock-video-orientation"   ;;
        "natural") parsed_config="${parsed_config} --lock-video-orientation=0" ;;
        "90 CCW")  parsed_config="${parsed_config} --lock-video-orientation=1" ;;
        "180")     parsed_config="${parsed_config} --lock-video-orientation=2" ;;
        "90 CW")   parsed_config="${parsed_config} --lock-video-orientation=3" ;;
    esac
    case $rotation in
        "no")      parsed_config="${parsed_config} --rotation 0" ;;
        "90 CCW")  parsed_config="${parsed_config} --rotation 1" ;;
        "180")     parsed_config="${parsed_config} --rotation 2" ;;
        "90 CW")   parsed_config="${parsed_config} --rotation 3" ;;
    esac

    echo "$parsed_config"
}

rofi_scrcpy_menu() {
    unset devices_array
    declare -A devices_array
    set_device_list
    local other_menu_items="config${sep}refresh"

    if [[ ! -z $device_list ]]; then
        local menu_items="${device_list}${sep}${other_menu_items}"
    else
        local menu_items=$other_menu_items
    fi

    local selected_menu="$(rofi -sep $sep -dmenu -config ~/.config/rofi/dmenu.rasi -i -p "scrcpy" <<< "${menu_items}")"
    case $selected_menu in
        "config") rofi_configuration_menu ;;
        "refresh") rofi_scrcpy_menu ;;
        *) rofi_device_menu "$selected_menu" ;;
    esac
}


rofi_configuration_menu() {
    add_missing_config

    local turn_screen_off_menu="turn screen off [$turn_screen_off]"
    local no_control_menu="no control [$no_control]"
    local hid_keyboard_menu="hid keyboard [$hid_keyboard]"
    local hid_mouse_menu="hid mouse [$hid_mouse]"
    local otg_menu="otg [$otg]"
    local power_off_on_close_menu="power off on close [$power_off_on_close]"
    local stay_awake_menu="stay awake [$stay_awake]"
    local print_fps_menu="print fps [$print_fps]"
    local max_size_menu="max size [$max_size]"
    local max_fps_menu="max fps [${max_fps}]"

    local bitrate_menu
    if [[ $bitrate == default ]]; then
        bitrate_menu="bitrate [default]"
    else
        bitrate_menu="bitrate [${bitrate} Mbps]"
    fi

    local display_buffer_menu
    if [[ $display_buffer == default ]]; then
        display_buffer_menu="display buffer [default]"
    else
        display_buffer_menu="display buffer [${display_buffer} ms]"
    fi

    local lock_orientation_menu
    case $lock_orientation in
        "no")      lock_orientation_menu="lock orientation [no]"      ;;
        "current") lock_orientation_menu="lock orientation [current]" ;;
        "natural") lock_orientation_menu="lock orientation [natural]" ;;
        "90 CW")   lock_orientation_menu="lock orientation [90 CW]"   ;;
        "90 CCW")  lock_orientation_menu="lock orientation [90 CCW]"  ;;
        "180")     lock_orientation_menu="lock orientation [180]"     ;;
    esac

    local rotation_menu
    case $rotation in
        "no")     rotation_menu="rotation [no]"     ;;
        "90 CW")  rotation_menu="rotation [90 CW]"  ;;
        "90 CCW") rotation_menu="rotation [90 CCW]" ;;
        "180")    rotation_menu="rotation [180]"    ;;
    esac

    local menu_items="${turn_screen_off_menu}
    ${sep}${bitrate_menu}
    ${sep}${hid_keyboard_menu}
    ${sep}${hid_mouse_menu}
    ${sep}${otg_menu}
    ${sep}${stay_awake_menu}
    ${sep}${power_off_on_close_menu}
    ${sep}${max_fps_menu}
    ${sep}${print_fps_menu}
    ${sep}${lock_orientation_menu}
    ${sep}${rotation_menu}
    ${sep}${display_buffer_menu}
    ${sep}${no_control_menu}
    ${sep}${max_size_menu}
    ${sep}reset
    ${sep}apply changes
    ${sep}<"

    local selected_menu="$(rofi -sep $sep -dmenu -config ~/.config/rofi/dmenu.rasi -i -p "config" <<< "${menu_items}")"
    case $selected_menu in
        "turn screen off"*)
            local option="$(get_current_option "$selected_menu")"
            sed -i "s/turn_screen_off.*/turn_screen_off=\"$(get_opposite $option)\"/g" $config_file
            rofi_configuration_menu
            ;;
        "no control"*)
            local option="$(get_current_option "$selected_menu")"
            sed -i "s/no_control.*/no_control=\"$(get_opposite $option)\"/g" $config_file
            rofi_configuration_menu
            ;;
        "hid keyboard"*)
            local option="$(get_current_option "$selected_menu")"
            sed -i "s/hid_keyboard.*/hid_keyboard=\"$(get_opposite $option)\"/g" $config_file
            rofi_configuration_menu
            ;;
        "hid mouse"*)
            local option="$(get_current_option "$selected_menu")"
            sed -i "s/hid_mouse.*/hid_mouse=\"$(get_opposite $option)\"/g" $config_file
            rofi_configuration_menu
            ;;
        "otg"*)
            local option="$(get_current_option "$selected_menu")"
            sed -i "s/otg.*/otg=\"$(get_opposite $option)\"/g" $config_file
            rofi_configuration_menu
            ;;
        "power off on close"*)
            local option="$(get_current_option "$selected_menu")"
            sed -i "s/power_off_on_close.*/power_off_on_close=\"$(get_opposite $option)\"/g" $config_file
            rofi_configuration_menu
            ;;
        "stay awake"*)
            local option="$(get_current_option "$selected_menu")"
            sed -i "s/stay_awake.*/stay_awake=\"$(get_opposite $option)\"/g" $config_file
            rofi_configuration_menu
            ;;
        "print fps"*)
            local option="$(get_current_option "$selected_menu")"
            sed -i "s/print_fps.*/print_fps=\"$(get_opposite $option)\"/g" $config_file
            rofi_configuration_menu
            ;;
        "bitrate"*)
            local bitrate="$(rofi -sep $sep -dmenu -config ~/.config/rofi/dmenu.rasi -i -p "Enter bitrate (Mbps)")"
            regex='^[1-9][0-9]*$'
            if [[ $bitrate =~ $regex ]] ; then
                sed -i "s/bitrate.*/bitrate=$bitrate/g" $config_file
            else
                sed -i 's/bitrate.*/bitrate="default"/g' $config_file
            fi
            rofi_configuration_menu
            ;;
        "max size"*)
            local max_size="$(rofi -sep $sep -dmenu -config ~/.config/rofi/dmenu.rasi -i -p "Enter max size")"
            regex='^[1-9][0-9]*$'
            if [[ $max_size =~ $regex ]] ; then
                sed -i "s/max_size.*/max_size=$max_size/g" $config_file
            else
                sed -i 's/max_size.*/max_size="default"/g' $config_file
            fi
            rofi_configuration_menu
            ;;
        "display buffer"*)
            local buffer="$(rofi -sep $sep -dmenu -config ~/.config/rofi/dmenu.rasi -i -p "display buffer (ms)")"
            if [[ $buffer -ge 0 ]] ; then
                sed -i "s/display_buffer.*/display_buffer=$buffer/g" $config_file
            else
                sed -i 's/display_buffer.*/display_buffer="default"/g' $config_file
            fi
            rofi_configuration_menu
            ;;
        "max fps"*)
            local fps="$(rofi -sep $sep -dmenu -config ~/.config/rofi/dmenu.rasi -i -p "Enter max fps")"
            regex='^[1-9][0-9]*$'
            if [[ $fps =~ $regex ]] ; then
                sed -i "s/max_fps.*/max_fps=$fps/g" $config_file
            else
                sed -i 's/max_fps.*/max_fps="default"/g' $config_file
            fi
            rofi_configuration_menu
            ;;
        "lock orientation"*)
            local menu_items="current${sep}natural${sep}90 CW${sep}90 CCW${sep}180${sep}no"
            local selected_menu="$(rofi -sep $sep -dmenu -config ~/.config/rofi/dmenu.rasi -i -p "lock orientation" <<< "${menu_items}")"

            if [[ ! -z $selected_menu ]]; then
                sed -i "s/lock_orientation.*/lock_orientation=\"$selected_menu\"/g" $config_file
            fi
            rofi_configuration_menu
            ;;
        "rotation"*)
            local menu_items="90 CW${sep}90 CCW${sep}180${sep}no"
            local selected_menu="$(rofi -sep $sep -dmenu -config ~/.config/rofi/dmenu.rasi -i -p "rotation" <<< "${menu_items}")"

            if [[ ! -z $selected_menu ]]; then
                sed -i "s/rotation.*/rotation=\"$selected_menu\"/g" $config_file
            fi
            rofi_configuration_menu
            ;;
        "reset"*)
            > $config_file
            unset_config_variables
            rofi_configuration_menu
            ;;
        "apply changes"*)
            local scrcpy_regex='.* scrcpy -s ([^[:space:]]+).*'
            while read -r line; do
                if [[ $line =~ $scrcpy_regex ]]; then
                    local device_serial="${BASH_REMATCH[1]}";
                    pkill --signal=9 -f "scrcpy -s $device_serial"
                    launch_scrcpy $device_serial
                fi
            done <<< $(pgrep -fla "scrcpy -s")
            # for device_id in "${!devices_array[@]}"; do
            #     local device_regex=".* \[(.*)\]"
            #     if [[ $device_id =~ $device_regex ]]; then
            #         local attribute="${BASH_REMATCH[1]}"

            #         if [[ $attribute == *running* ]]; then
            #             local device_serial="${devices_array[$device_id]}"
            #             pkill --signal=9 -f "scrcpy -s $device_serial"
            #             dunstify "${device_serial}"
            #             launch_scrcpy $device_serial
            #         fi
            #     fi
            # done
            ;;
        "<") rofi_scrcpy_menu ;;
    esac

}

# rofi_configuration_menu
rofi_scrcpy_menu
