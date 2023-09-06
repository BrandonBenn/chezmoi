-- Set Options
vim.cmd.colorscheme("typograph")
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 20
vim.o.exrc = true
vim.o.title = true
vim.o.hidden = true
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
vim.o.showmode = false
vim.o.laststatus = 3
vim.o.cursorline = false
vim.opt.statusline = [[ ]]
vim.o.completeopt = "menu"

-- Set Keymaps
local keymap = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local options = { remap = true, silent = true }
keymap('n', '<leader>w', vim.cmd.update, options)
keymap('n', '<c-w>q', function()
      local multiple_windows, _ = pcall(vim.cmd, "close")
      if not multiple_windows then
        vim.cmd("bd")
      end
    end
, options)
keymap('n', '<C-w>t', vim.cmd.tabnew, options)
keymap('n', '<Tab>', vim.cmd.tabnext, options)
keymap('n', '<S-Tab>', vim.cmd.tabprevious, options)
keymap('v', '<', '<gv', options)
keymap('v', '>', '>gv', options)
keymap('n', '<C-t><C-t>', ':tabnew | terminal<cr>', options)
keymap('n', '<C-t>v', ':vsplit | terminal<cr>', options)
keymap('n', '<C-t>s', ':split | terminal<cr>', options)
keymap('i', '<Tab>', function() return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>" end, { expr = true })
keymap('n', '-', vim.cmd.Ex, options)
keymap('n', '<leader>v', vim.cmd.Lex, options)
autocmd('LspAttach', {
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true, remap = true }
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    keymap({ 'n', 'v' }, 'gq', vim.lsp.buf.format, options)
    keymap('n', 'gd', vim.lsp.buf.definition, opts)
    keymap('n', 'gr', vim.lsp.buf.references, opts)
    keymap('n', 'K', vim.lsp.buf.hover, opts)
    keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)
    keymap('n', '<leader><leader>', vim.lsp.buf.code_action, opts)
  end,
})
keymap('n', '[d', vim.diagnostic.goto_prev, options)
keymap('n', ']d', vim.diagnostic.goto_next, options)
keymap('n', 'gl', function() vim.diagnostic.open_float({ scope = 'line' }) end, options)
keymap('n', '<leader>q', vim.diagnostic.setqflist, options)
