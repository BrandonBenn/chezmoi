-- Set Options
vim.cmd.colorscheme("typograph")
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.netrw_banner = 0
vim.o.exrc = true
vim.o.title = true
vim.o.hidden = true
vim.o.laststatus = 0
vim.o.number = true
vim.o.relativenumber = true
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
vim.opt.guifont = { "JetBrains Mono", "h14" }
vim.o.background = 'light'

-- Set Keymaps
local options = { remap = true, silent = true }
vim.keymap.set('v', '<', '<gv', options)
vim.keymap.set('v', '>', '>gv', options)
vim.keymap.set({ 'v', 'n' }, ';', ':', { silent = false })
vim.keymap.set({ 'n', 'v' }, 'g=', vim.lsp.buf.format, options)
vim.keymap.set('n', '-', vim.cmd.Ex, options)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, options)
vim.keymap.set('n', '<LocalLeader>ca', vim.lsp.buf.code_action, options)
require('notes').setup({
  notes_dir = '~/Sync/20-29-Personal/20-Notes'
})

if vim.g.neovide then
  vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
  vim.g.neovide_input_macos_alt_is_meta = true

  for _, key in ipairs({ 'C', 'D' }) do
    vim.keymap.set('n', '<' .. key .. '-s>', ':w<CR>') -- Save
    vim.keymap.set('v', '<' .. key .. '-c>', '"+y') -- Copy
    vim.keymap.set('n', '<' .. key .. '-v>', '"+P') -- Paste normal mode
    vim.keymap.set('v', '<' .. key .. '-v>', '"+P') -- Paste visual mode
    vim.keymap.set('c', '<' .. key .. '-v>', '<C-R>+') -- Paste command mode
    vim.keymap.set('i', '<' .. key .. '-v>', '<ESC>l"+Pli') -- Paste insert mode
  end

  vim.g.neovide_scale_factor = 1.0
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end

  for _, key in ipairs({ 'C', 'D' }) do
    vim.keymap.set("n", "<" .. key .. "-=>", function()
      change_scale_factor(1.25)
    end)

    vim.keymap.set("n", "<" .. key .. "-->", function()
      change_scale_factor(1 / 1.25)
    end)
  end
end
