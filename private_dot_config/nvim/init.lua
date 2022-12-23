-- Set Options
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.netrw_banner = 0
vim.o.number = true
vim.o.relativenumber = true
vim.o.shortmess = "IfilnxtToOF"
vim.o.expandtab = true
vim.o.exrc = true
vim.o.hidden = true
vim.o.laststatus = 0
vim.o.scrolloff = 999
vim.o.shiftwidth = 2
vim.o.showmode = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.softtabstop = 2
vim.o.spell = true
vim.o.spelloptions = "camel"
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.udir = "/tmp/nvim/undo"
vim.o.undofile = true
vim.o.wrap = false
vim.o.cmdheight = 0
vim.cmd.colorscheme("typograph")

-- Set Keymaps
vim.keymap.set("v", "<", "<gv", { remap = true })
vim.keymap.set("v", ">", ">gv", { remap = true })
vim.keymap.set({ "v", "n" }, ";", ":", { remap = true })
vim.keymap.set("n", "<Tab>", ":tabnext<CR>", { silent = true, remap = true })
vim.keymap.set("n", "<S-Tab>", ":tabprev<CR>", { silent = true, remap = true })
vim.keymap.set({ "n", "v" }, "g=", vim.lsp.buf.format, { silent = true })

-- Set Commands
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
	pattern = { "term://*", "*.txt", "*.tex", "*.md" },
	callback = function()
		vim.opt_local["number"] = false
		vim.opt_local["relativenumber"] = false
	end,
})

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	callback = function()
		vim.opt_local["number"] = true
		vim.opt_local["relativenumber"] = false
	end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	callback = function()
		vim.opt_local["number"] = true
		vim.opt_local["relativenumber"] = true
	end,
})

if vim.g.vscode then
	return
end

require("plugins")
