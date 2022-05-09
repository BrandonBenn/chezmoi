local gitsigns = require("gitsigns")

gitsigns.setup()

vim.keymap.set("n", "<leader>gb", gitsigns.toggle_current_line_blame, { silent = true })

if vim.env.WEZTERM_PANE == "0" then
	vim.keymap.set("n", "<leader>gg", function()
		vim.fn.system("wezterm cli spawn --cwd " .. vim.fn.getcwd() .. " -- gitui")
	end, { silent = true })
end
