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
vim.opt.wildmenu = true
vim.opt.wildmode = { "longest", "full" }
vim.opt.wildchar = ("\t"):byte()
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
local keymap = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

-- Set Default Keymaps
keymap("v", "<", "<gv", { remap = true })
keymap("v", ">", ">gv", { remap = true })
keymap({ "v", "n" }, ";", ":", { remap = true })
keymap("t", "<Esc>", "<C-\\><C-n>", { silent = true, remap = true })
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
vim.g.copilot_filetypes = {
	["*"] = true,
	["TelescopePrompt"] = false,
}

-- Readline actions in command-line mode
local readline = require("readline")
keymap("!", "<M-f>", readline.forward_word)
keymap("!", "<M-b>", readline.backward_word)
keymap("!", "<C-a>", readline.beginning_of_line)
keymap("!", "<C-e>", readline.end_of_line)
keymap("!", "<M-d>", readline.kill_word)
keymap("!", "<C-w>", readline.backward_kill_word)
keymap("!", "<C-k>", readline.kill_line)
keymap("!", "<C-u>", readline.backward_kill_line)

-- Tab actions
keymap("n", "<C-t>t", ":tabnew<CR>", { silent = true, remap = true })
keymap("n", "<C-t>n", ":tabnext<CR>", { silent = true, remap = true })
keymap("n", "<C-t>p", ":tabprevious<CR>", { silent = true, remap = true })
keymap("n", "<C-t>q", ":tabclose<CR>", { silent = true, remap = true })
