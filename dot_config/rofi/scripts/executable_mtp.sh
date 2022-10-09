#!/usr/bin/bash
sep="|"
declare -A mountable_devices_array
populate_mountable_devices_array() {
    local data=$(gio mount -li | grep -e '^Volume' -e 'activation_root' | sed -e 's/\s*activation_root=//g' -e 's/Volume(.*):\s//g')
    local no_lines=$(echo "$data" | grep -c '^')
    local count=1

    if [[ $(( no_lines % 2 )) -eq 0 ]]; then
        while read -r line; do
            if [[ ! $(( count % 2 )) -eq 0 ]]; then
                local device_name="$line"
            fi

            if [[ $(( count % 2 )) -eq 0 ]]; then
                if [[ ! -z $device_name ]]; then
                    mountable_devices_array[$device_name]="$line"
                fi
                device_name=''
            fi

            count=$(( count + 1 ))
        done <<< $data

    fi
}

get_device_list() {
    local counter=1
    local device_list


    for device_name in "${!mountable_devices_array[@]}"; do
        local device_id="${mountable_devices_array[$device_name]}"
        # dunstify "$device_name"

        if (gio mount -l | grep '^Mount([1-9]).*'"${mountable_devices_array[$device_name]}") 1>/dev/null; then
            local device_attributes="mounted"
        else
            local device_attributes="not mounted"
        fi

        if [ $counter -gt 1 ]; then
            device_list="$device_list$sep$device_name [$device_attributes]"
        else
            device_list="$device_name [$device_attributes]"
        fi
        counter=$(( counter + 1 ))
    done

    echo "$device_list"
}

rofi_mount_menu() {
    populate_mountable_devices_array
    local devices=$(get_device_list)
    local selected_menu="$(rofi -sep $sep -dmenu -config ~/.config/rofi/dmenu.rasi -i -p "mtp devices" <<< "${devices}")"

    local regex="(.*) \[(.*)\]"
    if [[ $selected_menu =~ $regex ]]; then
        local device_name="${BASH_REMATCH[1]}"
        local mount_status="${BASH_REMATCH[2]}"
        local device_activation_root="${mountable_devices_array[$device_name]}"
    fi

    if [[ $mount_status == "mounted" ]]; then
        gio mount -u "${mountable_devices_array[$device_name]}"
    elif [[ $mount_status == "not mounted" ]]; then
        gio mount "${mountable_devices_array[$device_name]}"
    fi
}

mtp-detect 1>/dev/null
rofi_mount_menu
