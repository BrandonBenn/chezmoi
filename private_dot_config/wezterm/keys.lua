local action = require("wezterm").action
local keys = {}

keys = {
  { key = "t",     mods = "SHIFT|CTRL", action = action { SpawnTab = "CurrentPaneDomain" } },
  { key = "Tab",   mods = "CTRL",       action = action.ActivateTabRelative(1) },
  { key = "Tab",   mods = "SHIFT|CTRL", action = action.ActivateTabRelative(-1) },
  { key = "y",     mods = "SHIFT|CTRL", action = action.PaneSelect { alphabet = "asdfghjkl", }, },
  { key = "w",     mods = "SHIFT|CTRL", action = action { CloseCurrentPane = { confirm = true } } },
  { key = "z",     mods = "SHIFT|CTRL", action = "TogglePaneZoomState" },
  { key = "h",     mods = "ALT",        action = action { ActivatePaneDirection = "Left" } },
  { key = "j",     mods = "ALT",        action = action { ActivatePaneDirection = "Down" } },
  { key = "k",     mods = "ALT",        action = action { ActivatePaneDirection = "Up" } },
  { key = "l",     mods = "ALT",        action = action { ActivatePaneDirection = "Right" } },
  { key = "H",     mods = "CTRL|ALT",   action = action { AdjustPaneSize = { "Left", 5 } } },
  { key = "J",     mods = "CTRL|ALT",   action = action { AdjustPaneSize = { "Down", 5 } } },
  { key = "K",     mods = "CTRL|ALT",   action = action { AdjustPaneSize = { "Up", 5 } } },
  { key = "L",     mods = "CTRL|ALT",   action = action { AdjustPaneSize = { "Right", 5 } } },
  { key = "V",     mods = "SHIFT|CTRL", action = action.PasteFrom("Clipboard") },
  { key = "C",     mods = "SHIFT|CTRL", action = action.CopyTo("Clipboard") },
  { key = "v",     mods = "SUPER",      action = action.PasteFrom("Clipboard") },
  { key = "c",     mods = "SUPER",      action = action.CopyTo("Clipboard") },
  { key = "u",     mods = "SHIFT|CTRL", action = action.QuickSelect },
  { key = "Enter", mods = "ALT",        action = action { SplitVertical = { domain = "CurrentPaneDomain" } } },
  { key = "Enter", mods = "SHIFT|ALT",  action = action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
  { key = " ",     mods = "SHIFT|CTRL", action = action.ActivateCopyMode },
  { key = '=',     mods = "CTRL",       action = action.IncreaseFontSize },
  { key = '-',     mods = "CTRL",       action = action.DecreaseFontSize },
}


for i = 1, 9 do
  keys[#keys + 1] = { key = tostring(i), mods = "ALT", action = action { ActivateTab = i - 1 } }
end


return keys
