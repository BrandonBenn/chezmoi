vim.g.mapleader = ' '
vim.o.showmode = false
vim.o.termguicolors = true
vim.o.relativenumber = true
vim.o.hidden = true
vim.o.undofile = true
vim.o.number = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop  = 4
vim.o.shiftwidth  = 4
vim.o.softtabstop = 4
vim.o.laststatus = 0
vim.o.udir = '/tmp/nvim/undo'
vim.o.swapfile = false
vim.o.exrc = true
vim.o.wrap = false
vim.o.completeopt = "menuone,noselect"

require 'utils'
require 'terminal'
vim.cmd [[nnoremap H ^]]
vim.cmd [[nnoremap L $]]
vim.cmd [[nnoremap <silent><Tab>   :bnext<cr>]]
vim.cmd [[nnoremap <silent><S-Tab> :bprev<cr>]]
vim.cmd [[nnoremap <silent>;w :update<cr>]]
vim.cmd [[nnoremap <silent>;bd :bd<cr>]]
vim.cmd [[nnoremap <silent>;noh :noh<cr>]]
vim.cmd [[nnoremap <silent><leader>p "+p]]
vim.cmd [[vnoremap <silent><leader>y "+y]]
vim.cmd [[nnoremap <silent><leader>y "+y]]
vim.cmd [[nnoremap <silent><leader>Y gg"+yG]]
vim.cmd [[vnoremap < <gv]]
vim.cmd [[vnoremap > >gv]]
vim.cmd [[command! ToggleMouse execute 'lua toggle_mouse()']]

require 'packages'
vim.cmd [[color bruin]]
vim.cmd [[nnoremap <silent><Leader>g :ZenMode<cr>]]
vim.cmd [[xnoremap <silent>ga :EasyAlign<cr>]]
