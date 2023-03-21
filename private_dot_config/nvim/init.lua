-- Set Options
vim.cmd.colorscheme("typograph")
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.netrw_banner = 0
vim.o.exrc = true
vim.o.title = true
vim.o.hidden = true
vim.o.laststatus = 0
vim.o.number = false
vim.o.relativenumber = false
vim.o.scrolloff = 999
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.termguicolors = true
vim.o.udir = "/tmp/nvim/undo"
vim.o.undofile = true
vim.o.wrap = false
vim.o.mouse = ""
vim.opt.guifont = { "Iosevka Nerd Font", "h14" }
vim.o.background = 'light'
vim.o.showmode = false

-- Set Keymaps
local options = { remap = true, silent = true }
vim.keymap.set('n', '<C-w>t', ':tabnew<cr>', options)
vim.keymap.set('n', '<Tab>', ':tabn<cr>', options)
vim.keymap.set('n', '<S-Tab>', ':tabp<cr>', options)
vim.keymap.set('v', '<', '<gv', options)
vim.keymap.set('v', '>', '>gv', options)
vim.keymap.set({ 'v', 'n' }, ';', ':', { silent = false })
vim.keymap.set({ 'n', 'v' }, 'g=', vim.lsp.buf.format, options)
vim.keymap.set('n', '-', vim.cmd.Ex, options)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, options)
vim.keymap.set('n', '<LocalLeader>ca', vim.lsp.buf.code_action, options)
require('notes').setup({
  notes_dir = vim.fn.expand(os.getenv('NOTES_DIR'))
})
