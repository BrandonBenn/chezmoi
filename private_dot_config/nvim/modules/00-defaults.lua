-- Set Default Options
vim.cmd("colorscheme typograph")
vim.g.mapleader = " "
vim.g.netrw_banner = 0
vim.opt.expandtab = true
vim.opt.exrc = true
vim.opt.hidden = true
vim.opt.laststatus = 0
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 999
vim.opt.shiftwidth = 2
vim.opt.showmode = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.spell = true
vim.opt.spelloptions = "camel"
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.udir = "/tmp/nvim/undo"
vim.opt.undofile = true
vim.opt.wrap = false
vim.opt.wildmenu = true
vim.opt.wildmode = { "longest", "list", "full" }
vim.opt.wildchar = ("\t"):byte()
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
local keymap = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

-- Set Default Keymaps
keymap("v", "<", "<gv", { remap = true })
keymap("v", ">", ">gv", { remap = true })
keymap({ "v", "n" }, ";", ":", { remap = true })
keymap("t", "<Esc>", "<C-\\><C-n>", { silent = true, remap = true })
keymap("n", "<Tab>", ":tabnext<CR>", { silent = true, remap = true })
keymap("n", "<S-Tab>", ":tabprev<CR>", { silent = true, remap = true })
keymap("n", "g=", function()
	vim.lsp.buf.format({ async = true })
end, { silent = true })

-- restore cursor's last position upon reopening the file
autocmd({ "BufReadPost" }, {
	callback = function()
		vim.cmd(
			[[ if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]]
		)
	end,
})

-- Automatically save file when focus is lost
autocmd("FocusLost", {
	pattern = "*",
	callback = function()
		vim.cmd("silent! wa")
		vim.notify("Autosaved")
	end,
})

autocmd({ "TermOpen", "BufEnter" }, {
	pattern = { "term://*", "*.txt", "*.tex", "*.md" },
	callback = function()
		vim.opt_local["number"] = false
		vim.opt_local["relativenumber"] = false
	end,
})

-- reload config file on change
autocmd("BufWritePost", {
	pattern = { vim.fn.expand("~/.config/nvim/") .. "**/*.lua" },
	callback = function()
		vim.cmd("silent! source %")
	end,
})

-- Set up the plugin defaults
require("Comment").setup()
require("impatient").enable_profile()
require("nvim-autopairs").setup({})
require("notes").setup({ notes_dir = vim.fn.expand(vim.env.NOTES_DIR) })
