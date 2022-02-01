#!/bin/bash

windowname=$(xdotool getactivewindow getwindowname)

# if [[ "$windowname" == "dropdown_terminal2" ]]
# then
#     if pgrep -a kitty | grep dropdown_terminal1
#     then
#         i3-msg '[title="dropdown_terminal1"] move absolute position 15 px 47 px, resize set 1890 px 850 px'
#         i3-msg '[title=dropdown_terminal2] kill'
#     else
#         i3-msg '[title=dropdown_terminal2] kill'
#     fi
# else
#     i3-msg 'kill'
# fi
# if pgrep -a kitty | grep dropdown_terminal1
# then

case "$windowname" in
    "dropdown_terminal1")
        i3-msg '[title="dropdown_terminal2"] move absolute position 15 px 47 px, resize set 1890 px 850 px'
        i3-msg '[title=dropdown_terminal1] kill'
        ;;
    "dropdown_terminal2")
        i3-msg '[title="dropdown_terminal1"] move absolute position 15 px 47 px, resize set 1890 px 850 px'
        i3-msg '[title=dropdown_terminal2] kill'
        ;;
    *)
        i3-msg 'kill'
esac
