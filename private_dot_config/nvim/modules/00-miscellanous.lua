local keymap = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

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

vim.g.copilot_filetypes = {
	["*"] = true,
	["TelescopePrompt"] = false,
}

-- Defer loading of copilot until it's after the first buffer is loaded
autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		vim.defer_fn(function()
			vim.cmd("packadd copilot.vim")
		end, 150)
	end,
})
