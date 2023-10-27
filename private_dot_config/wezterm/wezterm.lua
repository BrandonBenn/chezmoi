local wezterm = require("wezterm")
return {
  leader = { key = "a", mods = "CTRL" },
  window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  disable_default_key_bindings = true,
  font = wezterm.font('Iosevka Nerd Font'),
  color_scheme = 'Calamity',
  keys = require("keys"),
}
