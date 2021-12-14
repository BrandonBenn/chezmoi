require("utils")
vim.g.mapleader = " "
vim.o.showmode = false
vim.o.termguicolors = true
vim.o.relativenumber = true
vim.o.hidden = true
vim.o.undofile = true
vim.o.number = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.laststatus = 0
vim.o.udir = "/tmp/nvim/undo"
vim.o.swapfile = false
vim.o.exrc = true
vim.o.title = true
vim.o.wrap = false
vim.o.scrolloff = 999
vim.o.completeopt = "menuone,noselect,noinsert"

nnoremap("gh", "^")
nnoremap("gl", "$")
nnoremap("<C-j>", ":cnext<cr>")
nnoremap("<C-k>", ":cprev<cr>")
nnoremap(";", ":")
vnoremap(";", ":")
nnoremap("<leader>p", [["+p]])
nnoremap("<leader>y", [["+y]])
vnoremap("<leader>y", [["+y]])
nnoremap("<leader>Y", [[gg"+yG]])
vnoremap("<", "<gv")
vnoremap(">", ">gv")
tnoremap("<Esc>", "<C-\\><C-n>")
tnoremap("<Esc>", "<C-\\><C-n>")
autocmd("TermOpen * setlocal nonumber norelativenumber")
vim.cmd([[cabbrev w update]])

-- Setup for github.com/mhinz/neovim-remote For opening files from within
-- :terminal without starting a nested nvim process.
if vim.env.NVIM_LISTEN_ADDRESS then
	vim.env.EDITOR = "nvr --remote"
	vim.env.GIT_EDITOR = "nvr -cc split --remote-wait"
end

vim.g.font_name = "Cascadia Code"
vim.g.font_size = 11
vim.o.guifont = vim.g.font_name .. ":h".. vim.g.font_size

function _G.resize_font(offset)
    vim.g.font_size = vim.g.font_size + offset
    vim.o.guifont = vim.g.font_name .. ":h".. vim.g.font_size
end

nnoremap("<C-=>", ":lua resize_font(2)<cr>")
nnoremap("<C-->", ":lua resize_font(-2)<cr>")
