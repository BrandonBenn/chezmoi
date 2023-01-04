-- Set Options
vim.cmd.colorscheme("typograph")
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.o.exrc = true
vim.o.hidden = true
vim.o.laststatus = 0
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 999
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.udir = "/tmp/nvim/undo"
vim.o.undofile = true
vim.o.wrap = false

-- Set Keymaps
vim.keymap.set("v", "<", "<gv", { remap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { remap = true, silent = true })
vim.keymap.set({ "v", "n" }, ";", ":", { remap = true, silent = true })
vim.keymap.set({ "n", "v" }, "g=", vim.lsp.buf.format, { remap = true, silent = true })

require("plugins")
