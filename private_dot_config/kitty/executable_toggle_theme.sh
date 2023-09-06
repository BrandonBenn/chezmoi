#!/usr/bin/env sh
#

if [ "$1" = "dark" ]; then
  ln -sf ~/.config/kitty/themes/dark.conf ~/.config/kitty/themes/current.conf
else
  ln -sf ~/.config/kitty/themes/light.conf ~/.config/kitty/themes/current.conf
fi

kitty @ set-colors --all --configured ~/.config/kitty/themes/current.conf
