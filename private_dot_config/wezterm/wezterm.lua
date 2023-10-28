local wezterm = require("wezterm")
local config = {}

config.disable_default_key_bindings = true
config.keys = require("keys")

config.color_scheme = 'Calamity'
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_background_opacity = 0.96
config.font = wezterm.font 'Iosevka Nerd Font'

return config
