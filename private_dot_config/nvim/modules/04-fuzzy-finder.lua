local keymap = vim.keymap.set
local merge = vim.tbl_deep_extend

local layout = require("telescope.actions.layout")
local themes = require("telescope.themes")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

require("telescope").setup({
	defaults = merge("force", themes.get_dropdown(), {
		preview = { hide_on_startup = true },
		extensions = {
			fzf = {
				fuzzy = true,
				override_file_sorter = true,
				override_generic_sorter = true,
				case_mode = "smart_case",
			},
		},
		mappings = {
			n = {
				["<M-p>"] = layout.toggle_preview,
				["d"] = actions.delete_buffer,
			},
			i = {
				["<M-p>"] = layout.toggle_preview,
				["<C-d>"] = actions.delete_buffer,
			},
		},
	}),
})

require("telescope").load_extension("fzf")

keymap("n", "<C-p>", builtin.fd, { silent = true })
keymap("n", "<leader>ff", builtin.fd, { silent = true })
keymap("n", "<leader>fo", builtin.oldfiles, { silent = true })
keymap("n", "<leader>fr", builtin.resume, { silent = true })
keymap("n", "<leader>fb", builtin.buffers, { silent = true })
keymap("n", "<leader>fg", function()
	builtin.live_grep(themes.get_ivy({}))
end, { silent = true })
keymap("n", "<leader>fw", function()
	builtin.grep_string(themes.get_ivy({}))
end, { silent = true })
