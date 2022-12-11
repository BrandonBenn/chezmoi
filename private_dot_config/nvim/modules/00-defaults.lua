-- Set Default Options
vim.cmd("colorscheme typograph")
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.netrw_banner = 0
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shortmess = "IfilnxtToOF"
vim.opt.expandtab = true
vim.opt.exrc = true
vim.opt.hidden = true
vim.opt.laststatus = 0
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
vim.opt.guifont = "JetBrains Mono:h13"
vim.opt.title = true
vim.opt.udir = "/tmp/nvim/undo"
vim.opt.undofile = true
vim.opt.wrap = false
vim.opt.cmdheight = 0
vim.opt.wildmenu = true
vim.opt.wildmode = { "longest", "full" }
vim.opt.wildchar = ("\t"):byte()
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
local keymap = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command

-- Set Default Keymaps
keymap("v", "<", "<gv", { remap = true })
keymap("v", ">", ">gv", { remap = true })
keymap({ "v", "n" }, ";", ":", { remap = true })
keymap("t", "<Esc>", "<C-\\><C-n>", { silent = true, remap = true })
keymap("n", "<Tab>", ":tabnext<CR>", { silent = true, remap = true })
keymap("n", "<S-Tab>", ":tabprev<CR>", { silent = true, remap = true })
keymap({ "n", "v" }, "g=", vim.lsp.buf.format, { silent = true })

-- restore cursor's last position upon reopening the file
autocmd({ "BufReadPost" }, {
	callback = function()
		vim.cmd(
			[[ if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]]
		)
	end,
})

autocmd({ "TermOpen", "BufEnter" }, {
	pattern = { "term://*", "*.txt", "*.tex", "*.md" },
	callback = function()
		vim.opt_local["number"] = false
		vim.opt_local["relativenumber"] = false
	end,
})

autocmd({ "InsertEnter" }, {
	callback = function()
		vim.opt_local["number"] = true
		vim.opt_local["relativenumber"] = false
	end,
})

autocmd({ "InsertLeave" }, {
	callback = function()
		vim.opt_local["number"] = true
		vim.opt_local["relativenumber"] = true
	end,
})

-- reload config file on change
autocmd("BufWritePost", {
	pattern = { vim.fn.expand("~/.config/nvim/") .. "**/*.lua" },
	callback = function()
		vim.cmd("silent! source %")
	end,
})

command("SendCommand", function(tbl)
	local terminal = tonumber(tbl.fargs[1])
	table.remove(tbl.fargs, 1)
	if tonumber(tbl.fargs[1]) ~= nil then
		command = tonumber(tbl.fargs[1])
	else
		command = table.concat(tbl.fargs, " ")
	end

	require("harpoon.term").sendCommand(terminal, command)
end, { nargs = "*", desc = "Commands to terminals" })
