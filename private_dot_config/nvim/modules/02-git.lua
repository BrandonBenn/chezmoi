local gitsigns = require("gitsigns")

gitsigns.setup()

vim.keymap.set("n", "<leader>gg", gitsigns.blame_line, { silent = true })

vim.api.nvim_create_user_command("Gitui", function()
	local terminal = require("toggleterm.terminal").Terminal
	terminal
		:new({
			cmd = "gitui",
			hidden = true,
			direction = "float",
		})
		:toggle()
end, { desc = "Toggle gitui" })
