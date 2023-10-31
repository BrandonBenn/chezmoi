local wezterm = require("wezterm")
local action = wezterm.action
local keys = {}
local is_macos = wezterm.target_triple == "aarch64-apple-darwin"


local mod1 = 'ALT'
local super = 'SUPER'
local ctrl_mod1 = 'CTRL|' .. mod1
local shift_mod1 = 'SHIFT|' .. mod1
local shift_ctrl = 'SHIFT|CTRL'

local mod4 = (is_macos and super or shift_ctrl)

keys = {
  { key = "Tab",   mods = "CTRL",     action = action.ActivateTabRelative(1) },
  { key = "Tab",   mods = shift_ctrl, action = action.ActivateTabRelative(-1) },
  { key = "h",     mods = mod1,       action = action { ActivatePaneDirection = "Left" } },
  { key = "j",     mods = mod1,       action = action { ActivatePaneDirection = "Down" } },
  { key = "k",     mods = mod1,       action = action { ActivatePaneDirection = "Up" } },
  { key = "l",     mods = mod1,       action = action { ActivatePaneDirection = "Right" } },
  { key = "h",     mods = ctrl_mod1,  action = action { AdjustPaneSize = { "Left", 5 } } },
  { key = "j",     mods = ctrl_mod1,  action = action { AdjustPaneSize = { "Down", 5 } } },
  { key = "k",     mods = ctrl_mod1,  action = action { AdjustPaneSize = { "Up", 5 } } },
  { key = "l",     mods = ctrl_mod1,  action = action { AdjustPaneSize = { "Right", 5 } } },
  { key = "Enter", mods = mod1,       action = action { SplitVertical = { domain = "CurrentPaneDomain" } } },
  { key = "Enter", mods = shift_mod1, action = action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
  { key = " ",     mods = shift_ctrl, action = action.ActivateCopyMode },
  { key = '=',     mods = mod4,       action = action.IncreaseFontSize },
  { key = '-',     mods = mod4,       action = action.DecreaseFontSize },
  { key = "t",     mods = mod4,       action = action { SpawnTab = "CurrentPaneDomain" } },
  { key = "u",     mods = mod4,       action = action.QuickSelect },
  { key = "y",     mods = mod4,       action = action.PaneSelect { alphabet = "asdfghjkl", }, },
  { key = "w",     mods = mod4,       action = action { CloseCurrentPane = { confirm = true } } },
  { key = "z",     mods = mod4,       action = "TogglePaneZoomState" },
  { key = '/',     mods = mod4,       action = action.Search("CurrentSelectionOrEmptyString") },
}

if is_macos then
  keys[#keys + 1] = { key = "v", mods = mod4, action = action.PasteFrom("Clipboard") }
  keys[#keys + 1] = { key = "c", mods = mod4, action = action.CopyTo("Clipboard") }
  keys[#keys + 1] = { key = 'p', mods = mod4, action = action.ActivateCommandPalette }
  keys[#keys + 1] = { key = 'k', mods = mod4, action = action.ClearScrollback 'ScrollbackAndViewport' }
  keys[#keys + 1] = { key = '+', mods = mod4, action = action.IncreaseFontSize }
  keys[#keys + 1] = { key = '-', mods = mod4, action = action.DecreaseFontSize }
else
  keys[#keys + 1] = { key = "V", mods = mod4, action = action.PasteFrom("Clipboard") }
  keys[#keys + 1] = { key = "C", mods = mod4, action = action.CopyTo("Clipboard") }
  keys[#keys + 1] = { key = 'P', mods = mod4, action = action.ActivateCommandPalette }
  keys[#keys + 1] = { key = 'K', mods = shift_ctrl, action = action.ClearScrollback 'ScrollbackAndViewport' }
  keys[#keys + 1] = { key = '+', mods = mod4, action = action.IncreaseFontSize }
  keys[#keys + 1] = { key = '_', mods = mod4, action = action.DecreaseFontSize }
end

for i = 1, 9 do
  keys[#keys + 1] = { key = tostring(i), mods = (is_macos and mod4 or mod1), action = action { ActivateTab = i - 1 } }
end


return keys
