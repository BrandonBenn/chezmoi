local wezterm = require("wezterm")
local c = wezterm.config_builder()

local mod = "CTRL|SHIFT"
if wezterm.target_triple == "aarch64-apple-darwin" then
	mod = "CMD"
end

local domain = { domain = "CurrentPaneDomain" }

c.color_scheme = "Modus-Operandi"
c.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
c.leader = { key = "a", mods = "CTRL" }
local scheme = wezterm.get_builtin_color_schemes()[c.color_scheme]
c.window_padding = { top = "4%" }
c.colors = {}
c.integrated_title_button_color = scheme.foreground
c.hide_tab_bar_if_only_one_tab = true
c.colors.tab_bar = {
	active_tab = {
		bg_color = scheme.background,
		fg_color = scheme.foreground,
	},
}

c.keys = {
	{ key = "a", mods = "LEADER|CTRL", action = wezterm.action({ SendString = "\x01" }) },
	{ key = "t", mods = mod, action = wezterm.action.ShowTabNavigator },
	{ key = "k", mods = mod, action = wezterm.action.ClearScrollback("ScrollbackAndViewport") },
	{ key = "s", mods = "LEADER", action = wezterm.action({ SplitVertical = domain }) },
	{ key = "v", mods = "LEADER", action = wezterm.action({ SplitHorizontal = domain }) },
	{ key = "p", mods = "LEADER", action = wezterm.action.PaneSelect({}) },
	{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
	{ key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
	{ key = "H", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
	{ key = "J", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
	{ key = "K", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
	{ key = "L", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },
	{ key = "1", mods = "LEADER", action = wezterm.action({ ActivateTab = 0 }) },
	{ key = "2", mods = "LEADER", action = wezterm.action({ ActivateTab = 1 }) },
	{ key = "3", mods = "LEADER", action = wezterm.action({ ActivateTab = 2 }) },
	{ key = "4", mods = "LEADER", action = wezterm.action({ ActivateTab = 3 }) },
	{ key = "5", mods = "LEADER", action = wezterm.action({ ActivateTab = 4 }) },
	{ key = "6", mods = "LEADER", action = wezterm.action({ ActivateTab = 5 }) },
	{ key = "7", mods = "LEADER", action = wezterm.action({ ActivateTab = 6 }) },
	{ key = "8", mods = "LEADER", action = wezterm.action({ ActivateTab = 7 }) },
	{ key = "9", mods = "LEADER", action = wezterm.action({ ActivateTab = 8 }) },
	{ key = "q", mods = "LEADER", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
	{ key = "x", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = false } }) },
}

return c
