local keymap = vim.keymap.set

local neogit  = require "neogit"
local gitsigns = require "gitsigns"
local diffview = require "diffview"

neogit.setup {
  disable_builtin_notifications = true,
  integrations = { diffview = true }
}
keymap('n', '<leader>Gg', neogit.open, {silent = true})

gitsigns.setup()
keymap('n', '<leader>Gl', gitsigns.toggle_current_line_blame, {silent = true})

diffview.setup {use_icons = false}
keymap('n', '<leader>Gd', neogit.open, {silent = true})

