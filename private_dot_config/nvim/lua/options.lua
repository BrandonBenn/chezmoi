vim.cmd.colorscheme("typograph")
vim.g.mapleader = " "
vim.g.maplocalleader = ","
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
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

if vim.fn.executable('rg') == 1 then
  vim.o.grepprg = 'rg --vimgrep --no-heading --smart-case --hidden --glob !.git'
  vim.o.grepformat = '%f:%l:%c:%m'
end

