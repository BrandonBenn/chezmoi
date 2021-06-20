runtime! plugin/utils.lua
color bruin
let mapleader = ';'
let g:netrw_liststyle=3
set nosmd tgc nu acd rnu udf scs
set laststatus=0 udir=/tmp/nvim/undo
autocmd BufWritePre * :%s/\s\+$//e
nmap L $
nmap H ^
nmap <leader>w :update<cr>
nmap <leader>f :Files<cr>
nmap <Leader>g :ZenMode<cr>
nmap <leader>y "+y
nmap <leader>Y gg"+yG
nmap <leader>p "+p
nmap <Leader>b :Buffers<cr>
xmap ga :EasyAlign<cr>
let g:deoplete#enable_at_startup=1
imap <C-j>     <Plug>(neosnippet_expand_or_jump)
smap <C-j>     <Plug>(neosnippet_expand_or_jump)
xmap <C-j>     <Plug>(neosnippet_expand_target)
