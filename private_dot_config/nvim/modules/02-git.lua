local command = vim.api.nvim_create_user_command
local keymap = vim.keymap.set

require("neogit").setup({
	integrations = {
		diffview = true,
	},
})
