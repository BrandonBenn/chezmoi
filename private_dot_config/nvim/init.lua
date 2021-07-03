require 'utils'
require 'terminal'
g.mapleader = ';'
opt.showmode = false
opt.termguicolors = true
opt.relativenumber = true
opt.hidden = true
opt.undofile = true
opt.number = true
opt.expandtab = true
opt.smartindent = true
opt.tabstop  = 4
opt.shiftwidth  = 4
opt.softtabstop = 4
opt.laststatus = 0
opt.udir = '/tmp/nvim/undo'
opt.swapfile = false
opt.exrc = true
opt.wrap = false
opt.mouse = "a"
opt.completeopt = "menuone,noselect"
g['netrw_liststyle'] = 3

cmd [[nnoremap <silent><leader>p "+p]]
cmd [[vnoremap <silent><leader>y "+y]]
cmd [[nnoremap <silent><leader>y "+y]]
cmd [[nnoremap <silent><leader>Y gg"+yG]]
cmd [[nnoremap <silent><leader>w :update<cr>]]
cmd [[nnoremap <silent><Tab>   :bnext<cr>]]
cmd [[nnoremap <silent><S-Tab> :bprev<cr>]]

require 'packages'
cmd [[color bruin]]
cmd [[autocmd BufWritePre * :RemoveTrailingSpaces]]
cmd [[nnoremap <silent><leader>f :Files<cr>]]
cmd [[nnoremap <silent><Leader>h :History<cr>]]
cmd [[nnoremap <silent><Leader>g :ZenMode<cr>]]
cmd [[nnoremap <silent><Leader>b :Buffers<cr>]]
cmd [[xnoremap ga :EasyAlign<cr>]]
cmd [[imap <C-j>     <Plug>(neosnippet_expand_or_jump)]]
cmd [[smap <C-j>     <Plug>(neosnippet_expand_or_jump)]]
cmd [[xmap <C-j>     <Plug>(neosnippet_expand_target)]]
