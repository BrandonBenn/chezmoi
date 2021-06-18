vim.cmd('runtime! plugin/utils.lua')
cmd 'color bruin'
g.mapleader = ';'
opt.ls   = 0
opt.cwh  = 1
opt.smd  = false
opt.tgc  = true
opt.nu   = true
opt.acd  = true
opt.rnu  = true
opt.udf  = true
opt.udir = '/tmp/nvim/undo'
cmd([[autocmd BufWritePre * :%s/\s\+$//e]])
map('n', 'L', '$')
map('n', 'H', '^')
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
map('v', 'ga', ':EasyAlign<cr>')
