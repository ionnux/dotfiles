#!/bin/bash
desktop=$(xdotool get_desktop)

if [[ "$desktop" == 0 ]]; then
  ~/.local/kitty.app/bin/kitty
else
  ~/.local/kitty.app/bin/kitty -o font_size=16
fi
