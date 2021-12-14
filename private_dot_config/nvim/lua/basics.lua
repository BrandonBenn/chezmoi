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
nnoremap("b]", ":bnext<cr>")
nnoremap("b[", ":bprev<cr>")
nnoremap("<localleader>w", ":update<cr>")
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

if vim.g.fvim_loaded == 1 then
	vim.o.guifont = "Cascadia Code:h11"
	nnoremap("<C-=>", ":set guifont=+<cr>")
	nnoremap("<C-->", ":set guifont=-<cr>")
end
