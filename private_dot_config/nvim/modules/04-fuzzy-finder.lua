vim.defer_fn(function()
	local keymap = vim.keymap.set
	local merge = vim.tbl_deep_extend

	local layout = require("telescope.actions.layout")
	local themes = require("telescope.themes")
	local actions = require("telescope.actions")
	local builtin = require("telescope.builtin")

	keymap("n", "mm", require("harpoon.ui").toggle_quick_menu, { silent = false })
	keymap("n", "m;", require("harpoon.mark").add_file, { silent = true })

	require("telescope").setup({
		defaults = {
			preview = { hide_on_startup = true },
			mappings = {
				i = { ["<M-p>"] = layout.toggle_preview },
				n = { ["<M-p>"] = layout.toggle_preview },
			},
		},
		pickers = {
			find_files = { theme = "dropdown" },
			oldfiles = { theme = "dropdown", only_cwd = true },
			live_grep = { theme = "ivy" },
			grep_string = { theme = "ivy" },
		},
	})

	keymap("n", "<C-p>p", builtin.find_files, { silent = true })
	keymap("n", "<C-p><C-p>", builtin.find_files, { silent = true })
	keymap("n", "<C-p>o", builtin.oldfiles, { silent = true })
	keymap("n", "<C-p>r", builtin.resume, { silent = true })
	keymap("n", "<C-p>g", builtin.live_grep, { silent = true })
	keymap("n", "<C-p>w", builtin.grep_string, { silent = true })

	local keys = { "a", "s", "d", "f", "g" }
	for k, v in pairs(keys) do
		keymap("n", "m" .. v, function()
			require("harpoon.ui").nav_file(k)
		end, { silent = true })
	end
end, 1500)
