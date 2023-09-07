-- Set Options
vim.cmd.colorscheme("typograph")
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 20
vim.g.netrw_keepdir = 0
vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro"
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

-- Set Keymaps
local autocmd = vim.api.nvim_create_autocmd
local keymap = function(mode, cmd, keys, options)
  local opts = options or { remap = true, silent = true }
  vim.keymap.set(mode, cmd, keys, opts)
end
keymap("n", ";w", vim.cmd.update)
keymap("n", "<c-w>q", function()
  local multiple_windows, _ = pcall(vim.cmd, "close")
  if not multiple_windows then vim.cmd("bd") end
end)
keymap("n", "<C-w>t", vim.cmd.tabnew)
keymap("i", "<C-o>", "<C-x><C-o>")
keymap("i", "<C-f>", "<C-x><C-f>")
keymap("n", "<Tab>", vim.cmd.tabnext)
keymap("n", "<S-Tab>", vim.cmd.tabprevious)
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")
keymap("n", "<C-t><C-t>", ":tabnew | terminal<cr>")
keymap("n", "<C-t>v", ":vsplit | terminal<cr>")
keymap("n", "<C-t>s", ":split | terminal<cr>")
keymap("i", "<Tab>", function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, { expr = true })
keymap("n", "-", vim.cmd.Ex)
keymap("n", "<leader>v", vim.cmd.Lex)
autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true, remap = true }
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    keymap({ "n", "v" }, "g=", vim.lsp.buf.format)
    keymap("n", "gd", vim.lsp.buf.definition, opts)
    keymap("n", "gr", vim.lsp.buf.references, opts)
    keymap("n", "K", vim.lsp.buf.hover, opts)
    keymap("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    keymap("n", "<leader>lr", vim.lsp.buf.rename, opts)
    keymap("n", "<leader>la", vim.lsp.buf.code_action, opts)
  end,
})
keymap("n", "[d", vim.diagnostic.goto_prev)
keymap("n", "]d", vim.diagnostic.goto_next)
keymap("n", "gl", function() vim.diagnostic.open_float({ scope = "line" }) end)
keymap("n", "<leader>q", vim.diagnostic.setqflist)
