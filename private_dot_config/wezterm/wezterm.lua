local wezterm = require('wezterm')

local keys = require('keys')
local color_scheme = require('color_scheme')

wezterm.on('update-status', color_scheme.set_appearance)

return {
  font = wezterm.font("Iosevka Nerd Font"),
  leader = { key = "a", mods = "CTRL" },
  enable_tab_bar = false,
  keys = keys,
}
