local neogit = require("neogit")
local gitsigns = require("gitsigns")
local diffview = require("diffview")

neogit.setup({
	disable_builtin_notifications = true,
	integrations = { diffview = true },
})

gitsigns.setup()
diffview.setup({ use_icons = false })

vim.keymap.set("n", "<leader>gg", neogit.open, { silent = true })
vim.keymap.set("n", "<leader>gb", gitsigns.toggle_current_line_blame, { silent = true })
vim.keymap.set("n", "<leader>gd", diffview.open, { silent = true })
