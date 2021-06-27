require 'utils'
g.mapleader = ';'
opt.showmode = false
opt.termguicolors = true
opt.relativenumber = true
opt.hidden = true
opt.undofile = true
opt.number  = true
opt.expandtab  = true
opt.smartindent  = true
opt.tabstop  = 4
opt.shiftwidth  = 4
opt.sts = 4
opt.laststatus = 0
opt.udir = '/tmp/nvim/undo'
opt.swapfile = false
opt.exrc = true
opt.wrap = false
opt.mouse = "a"

g['netrw_liststyle'] = 3
g['deoplete#enable_at_startup'] = 1

cmd [[color bruin]]
cmd [[autocmd BufWritePre * :RemoveTrailingSpaces]]
cmd [[nnoremap L $]]
cmd [[nnoremap H ^]]
cmd [[nnoremap <leader>w :update<cr>]]
cmd [[nnoremap <leader>f :Files<cr>]]
cmd [[nnoremap <Leader>h :History<cr>]]
cmd [[nnoremap <Leader>g :ZenMode<cr>]]
cmd [[nnoremap <leader>y "+y]]
cmd [[nnoremap <leader>Y gg"+yG]]
cmd [[nnoremap <leader>p "+p]]
cmd [[nnoremap <Leader>b :Buffers<cr>]]
cmd [[nnoremap <leader>= :Neoformat<cr>]]
cmd [[xnoremap ga :EasyAlign<cr>]]
cmd [[imap <C-j>     <Plug>(neosnippet_expand_or_jump)]]
cmd [[smap <C-j>     <Plug>(neosnippet_expand_or_jump)]]
cmd [[xmap <C-j>     <Plug>(neosnippet_expand_target)]]
