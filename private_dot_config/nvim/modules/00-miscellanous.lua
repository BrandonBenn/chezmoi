local keymap = vim.keymap.set
-- Readline actions in command-line mode
local readline = require("readline")
keymap("!", "<M-f>", readline.forward_word)
keymap("!", "<M-b>", readline.backward_word)
keymap("!", "<C-a>", readline.beginning_of_line)
keymap("!", "<C-e>", readline.end_of_line)
keymap("!", "<M-d>", readline.kill_word)
keymap("!", "<C-w>", readline.backward_kill_word)
keymap("!", "<C-k>", readline.kill_line)
keymap("!", "<C-u>", readline.backward_kill_line)

-- Vim Test
vim.g["test#strategy"] = {
	nearest = "kitty",
	file = "kitty",
	suite = "kitty",
}

vim.g.copilot_filetypes = {
	["*"] = true,
	["TelescopePrompt"] = false,
}
