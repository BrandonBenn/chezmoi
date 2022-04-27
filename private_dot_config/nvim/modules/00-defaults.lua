vim.cmd("colorscheme typograph")
vim.g.mapleader = " "
vim.opt.expandtab = true
vim.opt.exrc = true
vim.opt.hidden = true
vim.opt.laststatus = 0
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 999
vim.opt.shiftwidth = 4
vim.opt.showmode = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.spell = true
vim.opt.spelloptions = "camel"
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.udir = "/tmp/nvim/undo"
vim.opt.undofile = true
vim.opt.wrap = false
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }

vim.keymap.set("v", "<", "<gv", { remap = true })
vim.keymap.set("v", ">", ">gv", { remap = true })
vim.keymap.set({ "v", "n" }, ";", ":", { remap = true })
vim.keymap.set({ "v", "n" }, ":<leader>y", '"+y')
vim.keymap.set({ "v", "n" }, ":<leader>p", '"+p')
vim.keymap.set("t", "<esc>", "C-\\><C-n>", { silent = true, remap = true })
vim.keymap.set("n", "g=", vim.lsp.buf.formatting, { silent = true })

-- restore cursor's last position upon reopening the file
-- reload config file on change
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { vim.fn.expand("~/.config/nvim/") .. "**/*.lua" },
	command = "silent source %",
})

vim.api.nvim_create_autocmd('FocusLost', { pattern = '*', command = 'silent! wa' })

vim.notify = require("notify")
vim.notify.setup({stages = "static"})
require("Comment").setup()
require("impatient").enable_profile()
require("notes").setup({notes_dir = vim.fn.expand(vim.env.NOTES_DIR)})
