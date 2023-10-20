vim.cmd.colorscheme("typograph")
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.exrc = true
vim.opt.title = true
vim.opt.hidden = true
vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.scrolloff = 999
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.udir = "/tmp/nvim/undo"
vim.opt.undofile = true
vim.opt.wrap = false
vim.opt.mouse = ""
vim.opt.showmode = false
vim.opt.laststatus = 3
vim.opt.cursorline = false
vim.opt.statusline = [[ ]]
vim.opt.completeopt = "menu"

if vim.fn.executable('rg') == 1 then
  vim.opt.grepprg = 'rg --vimgrep --no-heading --smart-case --hidden --glob !.git'
  vim.opt.grepformat = '%f:%l:%c:%m'

  local function grep(opts)
    local q = opts.args
    if type(q) == 'table' then
      q = table.concat(q, ' ')
    end

    local args = vim.fn.split([[']] .. q .. [[']])
    vim.cmd.grep { args = args, bang = true }
    vim.cmd.copen()
  end
  vim.api.nvim_create_user_command('Grep', grep, { nargs = "?" })
end
