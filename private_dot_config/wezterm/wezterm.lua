local M = {}
local wez = require("wezterm")

M.enable_tab_bar = false

local color_scheme = "Terminal Basic"
M.color_scheme = color_scheme
M.keys = {
	{ key = "t", mods = "ALT", action = "ShowTabNavigator" },
}

return M
