local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command
local keymap = vim.keymap.set

local set_terminal_keymaps = function()
	local opts = { noremap = true, buffer = 0 }
	keymap("t", "<C-W>h", [[<C-\><C-n><C-W>h]], opts)
	keymap("t", "<C-W>j", [[<C-\><C-n><C-W>j]], opts)
	keymap("t", "<C-W>k", [[<C-\><C-n><C-W>k]], opts)
	keymap("t", "<C-W>l", [[<C-\><C-n><C-W>l]], opts)
end
autocmd("TermOpen", { pattern = { "term://*" }, callback = set_terminal_keymaps })

function clear_term(options)
	local options = options or { reset = false }
	vim.opt_local.scrollback = 1
	vim.api.nvim_command("startinsert")
	if options.reset then
		vim.api.nvim_feedkeys("reset", "t", false)
	else
		vim.api.nvim_feedkeys("clear", "t", false)
	end
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<cr>", true, false, true), "t", true)
	vim.opt_local.scrollback = 10000
end

command("ClearTerm", function()
	clear_term({ reset = false })
end, { desc = "Clear Terminal Screen" })

command("ResetTerm", function()
	clear_term({ reset = true })
end, { desc = "Clear Terminal Screen" })

for i = 1, 5 do
	keymap({ "n" }, "m" .. i, function()
		require("harpoon.term").gotoTerminal(i)
	end, { silent = true, remap = true })

	keymap({ "i", "n" }, "<A-" .. i .. ">", function()
		require("harpoon.term").gotoTerminal(i)
	end, { silent = true, remap = true })
end
