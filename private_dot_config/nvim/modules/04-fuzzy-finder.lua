local keymap = vim.keymap.set
local merge = vim.tbl_deep_extend

local layout = require("telescope.actions.layout")
local themes = require("telescope.themes")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

require("telescope").setup({
	defaults = { preview = false },
	pickers = {
		find_files = {
			theme = "dropdown",
			find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
		},
		oldfiles = { theme = "dropdown", only_cwd = true },
		live_grep = { theme = "ivy" },
		grep_string = { theme = "ivy" },
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_file_sorter = true,
			override_generic_sorter = true,
			case_mode = "smart_case",
		},
	},
	mappings = {
		i = { ["<M-p>"] = layout.toggle_preview },
		n = { ["p"] = layout.toggle_preview },
	},
})

require("telescope").load_extension("fzf")

keymap("n", "<C-p>p", builtin.find_files, { silent = true })
keymap("n", "<C-p><C-p>", builtin.find_files, { silent = true })
keymap("n", "<C-p>o", builtin.oldfiles, { silent = true })
keymap("n", "<C-p>r", builtin.resume, { silent = true })
keymap("n", "<C-p>g", builtin.live_grep, { silent = true })
keymap("n", "<C-p>w", builtin.grep_string, { silent = true })
