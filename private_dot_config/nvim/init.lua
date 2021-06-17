local cmd, fn, g, opt = vim.cmd, vim.fn, vim.g, vim.opt
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

cmd 'color bruin'
g.mapleader = ';'
opt.ls  = 0
opt.cwh = 1
opt.tgc = true
opt.nu  = true
opt.acd = true
opt.rnu = true
opt.udf = true
cmd('command! Buffers Telescope buffers')
cmd('command! Finder  Telescope file_browser')
cmd('command! Files   Telescope find_files')
cmd('command! Grep    Telescope live_grep')
cmd([[autocmd BufWritePre * :%s/\s\+$//e]])
map('n', 'L', '$')
map('n', 'H', '^')
map('i', 'jj', '<ESC>')
map('n', '<leader>w', ':update<cr>')
map('n', '<leader>bd', ':bd<cr>')
map('n', '<leader>noh', ':noh<cr>')
map('n', '<leader>q', ':q<cr>')
map('n', '<Leader>bb', ':Buffers<cr>')
map('n', '<leader>f', ':Files<cr>')
map('n', '<Leader>g', ':Goyo<cr>')
map('n', '<leader>y', '"+y')
map('n', '<leader>Y', 'gg"+yG')
map('n', '<leader>p', '"+p')
map('x', 'ga', '<Plug>(EasyAlign)')
