#!/bin/bash

sleep 1
approvals_window_regex="https://cvradmin\.inecnigeria\.org/approvals/browsePendingForEo.*"
window_title="$(xdotool getwindowname "$(bspc query --nodes --node focused)")"

# echo "$window_title" | xclip -selection c

dunstify "Cvr automation started"
counter=0
while [[ $window_title =~ $approvals_window_regex && counter -le 300 ]]; do

    xdotool type fx
    while [[ $window_title =~ $approvals_window_regex && counter -le 300 ]]; do
        sleep 0.2
        window_title="$(xdotool getwindowname "$(bspc query --nodes --node focused)")"
        counter=$(( counter + 1 ))
    done

    application_window_regex='View Application: .*'
    if [[ $window_title =~ $application_window_regex ]]; then
        counter=0
        sleep 0.5
        xdotool key shift+g
        sleep 0.5
        xdotool type fr

        while [[ $window_title =~ $application_window_regex && counter -le 300 ]]; do
            sleep 0.2
            window_title="$(xdotool getwindowname "$(bspc query --nodes --node focused)")"
            counter=$(( counter + 1 ))
        done
    fi

done

dunstify "Cvr automation stopped"
