runtime! plugin/utils.lua
color bruin
let mapleader = ';'
let g:netrw_liststyle=3
set nosmd tgc nu rnu acd hid udf gcr et si ts=4 sw=4 sts=4
set laststatus=0 udir=/tmp/nvim/undo noswapfile exrc
set nowrap so=8 mouse=a
autocmd BufWritePre * :%s/\s\+$//e
nnoremap L $
nnoremap H ^
nnoremap <leader>w :update<cr>
nnoremap <leader>f :Files<cr>
nnoremap <Leader>h :History<cr>
nnoremap <Leader>g :ZenMode<cr>
nnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG
nnoremap <leader>p "+p
nnoremap <Leader>b :Buffers<cr>
nnoremap <leader>= :Neoformat<cr>
xnoremap ga :EasyAlign<cr>
let g:deoplete#enable_at_startup = 1
let g:neoformat_try_formatprg    = 1
imap <C-j>     <Plug>(neosnippet_expand_or_jump)
smap <C-j>     <Plug>(neosnippet_expand_or_jump)
xmap <C-j>     <Plug>(neosnippet_expand_target)
