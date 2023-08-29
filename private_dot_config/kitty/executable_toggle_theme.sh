#!/usr/bin/env sh
#

if [ "$1" = "dark" ]; then
  cp ~/.config/kitty/themes/dark.conf ~/.config/kitty/themes/current.conf
else
  cp ~/.config/kitty/themes/light.conf ~/.config/kitty/themes/current.conf
fi

kitty @ set-colors --all --configured ~/.config/kitty/themes/current.conf
