local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Modus-Operandi'
config.font = wezterm.font_with_fallback { 'Iosevka Term', 'JetBrains Mono' }
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
if wezterm.target_triple == 'aarch64-apple-darwin' then
  config.integrated_title_button_style = "MacOsNative"
else
  config.integrated_title_buttons = { 'Close' }
  config.integrated_title_button_style = "Gnome"
end

-- local scheme = wezterm.get_builtin_color_schemes()[config.color_scheme]
-- config.window_frame = {
--   inactive_titlebar_bg = scheme.background,
--   active_titlebar_bg = scheme.background,
--   button_bg = scheme.background,
--   button_hover_bg = scheme.background,
-- }


config.window_background_opacity = 0.96
config.keys = {
  {
    key = 'LeftArrow',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'RightArrow',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    key = 'UpArrow',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'DownArrow',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
    key = 'LeftArrow',
    mods = 'ALT|SHIFT',
    action = wezterm.action.AdjustPaneSize { 'Left', 5 },
  },
  {
    key = 'RightArrow',
    mods = 'ALT|SHIFT',
    action = wezterm.action.AdjustPaneSize { 'Right', 5 },
  },
  {
    key = 'UpArrow',
    mods = 'ALT|SHIFT',
    action = wezterm.action.AdjustPaneSize { 'Up', 5 },
  },
  {
    key = 'DownArrow',
    mods = 'ALT|SHIFT',
    action = wezterm.action.AdjustPaneSize { 'Down', 5 },
  },
}

return config
