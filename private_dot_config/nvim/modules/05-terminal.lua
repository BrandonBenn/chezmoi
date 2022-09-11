vim.defer_fn(function()
	local autocmd = vim.api.nvim_create_autocmd
	local command = vim.api.nvim_create_user_command
	local keymap = vim.keymap.set

	local set_terminal_keymaps = function()
		local opts = { noremap = true, buffer = 0 }
		keymap("t", "<esc>", [[<C-\><C-n>]], opts)
		keymap("t", "<C-W>h", [[<C-\><C-n><C-W>h]], opts)
		keymap("t", "<C-W>j", [[<C-\><C-n><C-W>j]], opts)
		keymap("t", "<C-W>k", [[<C-\><C-n><C-W>k]], opts)
		keymap("t", "<C-W>l", [[<C-\><C-n><C-W>l]], opts)
	end
	autocmd("TermOpen", { pattern = { "term://*" }, callback = set_terminal_keymaps })

	for i = 1, 5 do
		keymap("n", "m" .. i, function()
			require("harpoon.term").gotoTerminal(i)
		end)
	end
end, 1000)
