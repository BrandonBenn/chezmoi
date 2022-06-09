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

vim.keymap.set("v", "<", "<gv", { remap = true })
vim.keymap.set("v", ">", ">gv", { remap = true })
vim.keymap.set({ "v", "n" }, ";", ":", { remap = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true, remap = true })
vim.keymap.set("n", "g=", function()
	vim.lsp.buf.format({ async = true })
end, { silent = true })

-- restore cursor's last position upon reopening the file
vim.api.nvim_create_autocmd("FocusLost", { pattern = "*", command = "silent! wa" })

-- reload config file on change
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { vim.fn.expand("~/.config/nvim/") .. "**/*.lua" },
	command = "silent source %",
})


local readline = require("readline")
vim.keymap.set("!", "<M-f>", readline.forward_word)
vim.keymap.set("!", "<M-b>", readline.backward_word)
vim.keymap.set("!", "<C-a>", readline.beginning_of_line)
vim.keymap.set("!", "<C-e>", readline.end_of_line)
vim.keymap.set("!", "<M-d>", readline.kill_word)
vim.keymap.set("!", "<C-w>", readline.backward_kill_word)
vim.keymap.set("!", "<C-k>", readline.kill_line)
vim.keymap.set("!", "<C-u>", readline.backward_kill_line)

require("Comment").setup()
require("impatient").enable_profile()
require("nvim-autopairs").setup({})
require("notes").setup({ notes_dir = vim.fn.expand(vim.env.NOTES_DIR) })

vim.g.copilot_filetypes = {
	["*"] = true,
	["TelescopePrompt"] = false,
}
