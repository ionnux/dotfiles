#!/bin/bash
sleep 1

# sleep 1
# approvals_window_regex="https://cvradmin\.inecnigeria\.org/approvals/browsePendingForEo.*"
# window_title="$(xdotool getwindowname "$(bspc query --nodes --node focused)")"

# # echo "$window_title" | xclip -selection c

# dunstify "Cvr automation started"
# counter=0
# while [[ $window_title =~ $approvals_window_regex && counter -le 300 ]]; do

#     xdotool type fx
#     while [[ $window_title =~ $approvals_window_regex && counter -le 300 ]]; do
#         sleep 0.2
#         window_title="$(xdotool getwindowname "$(bspc query --nodes --node focused)")"
#         counter=$(( counter + 1 ))
#     done

#     application_window_regex='View Application: .*'
#     if [[ $window_title =~ $application_window_regex ]]; then
#         counter=0
#         sleep 0.5
#         xdotool key shift+g
#         sleep 0.5
#         xdotool type fr

#         while [[ $window_title =~ $application_window_regex && counter -le 300 ]]; do
#             sleep 0.2
#             window_title="$(xdotool getwindowname "$(bspc query --nodes --node focused)")"
#             counter=$(( counter + 1 ))
#         done
#     fi

# done

# dunstify "Cvr automation stopped"



application_page() {
    old_address="$(xdotool getwindowname "$(bspc query --nodes --node focused)")"
    sleep 0.5
    xdotool key shift+g
    sleep 0.5
    xdotool type fr

    is_new_application="no"
    counter=0
    while [[ $old_address =~ $application_window_regex && $is_new_application = no && $counter -le 300 ]]; do
        sleep 0.2
        new_address="$(xdotool getwindowname "$(bspc query --nodes --node focused)")"

        if [[ $new_address != $old_address ]]; then
            is_new_application="yes"
        fi
        counter=$(( counter + 1 ))
    done
}
approval_list_page() {
    xdotool type fc
    while [[ $window_title =~ $approvals_window_regex && $counter -le 300 ]]; do
        sleep 0.2
        window_title="$(xdotool getwindowname "$(bspc query --nodes --node focused)")"
        counter=$(( counter + 1 ))
    done

    if [[ $window_title =~ $application_window_regex ]]; then
        application_page
    fi
}

approval_menu_page() {
    xdotool type fz
    while [[ $window_title =~ $application_approvals_menu_regex && $counter -le 300 ]]; do
        sleep 0.2
        window_title="$(xdotool getwindowname "$(bspc query --nodes --node focused)")"
        counter=$(( counter + 1 ))
    done

    if [[ $window_title =~ $approvals_window_regex ]]; then
        approval_list_page
    fi
}

approvals_window_regex="https://cvradmin\.inecnigeria\.org/approvals/browsePendingForEo.*"
application_window_regex='View Application: .*'
application_approvals_menu_regex="Application Approvals - Vivaldi"
window_title="$(xdotool getwindowname "$(bspc query --nodes --node focused)")"

# echo "$window_title" | xclip -selection c

dunstify "Cvr automation started"
counter=0
while [[ $window_title =~ ($approvals_window_regex|$application_window_regex|$application_approvals_menu_regex) && $counter -le 300 ]]; do
    if [[ $window_title =~ $approvals_window_regex ]]; then
        approval_list_page
    elif [[ $window_title =~ $application_window_regex ]]; then
        application_page
    elif [[ $window_title =~ $application_approvals_menu_regex ]]; then
        approval_menu_page
    fi
    window_title="$(xdotool getwindowname "$(bspc query --nodes --node focused)")"
done
dunstify "Cvr automation stopped"
