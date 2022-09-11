local keymap = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

keymap("x", "ga", "<Plug>(EasyAlign)")

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

local function setup_copilot()
	vim.cmd("packadd copilot.vim")
	vim.g.copilot_filetypes = { ["*"] = true, ["TelescopePrompt"] = false }
	vim.g.copilot_no_tab_map = true
	keymap("i", "<silent><script><expr> <C-J>", [[copilot#Accept("\<CR>")]])
end

autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		vim.defer_fn(function()
			setup_copilot()
			require("gitsigns").setup()
		end, 1500)
	end,
})
