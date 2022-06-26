local command = vim.api.nvim_create_user_command
local keymap = vim.keymap.set

command("Gitui", function()
	local terminal = require("toggleterm.terminal").Terminal
	terminal
		:new({
			cmd = "gitui",
			hidden = true,
			direction = "float",
		})
		:toggle()
end, { desc = "Toggle gitui" })
