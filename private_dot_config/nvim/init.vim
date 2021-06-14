let mapleader = " "
let maplocalleader = ";"

let g:goyo_width = 89
let g:yui_comments = 'fade'

set termguicolors | color bruin
set noshowmode noruler laststatus=0 noshowcmd cmdheight=1
set backspace=indent,eol,start
set relativenumber number
set autochdir

command! Buffers Telescope buffers
command! Finder  Telescope file_browser
command! Files   Telescope find_files
command! Grep    Telescope live_grep

nmap H ^
nmap L $
nmap <silent>- :Finder<cr>
nmap <localleader>; :update<cr>
nmap <localleader>bd :bd<cr>
nmap <localleader>noh :noh<cr>
nmap <localleader>q :x<cr>
nmap <Leader>R :runtime! ~/.config/nvim/*/*<cr>
nmap <Leader>b :Buffers<cr>
nmap <Leader>g :Goyo<cr>
nmap <leader>y "+y
vmap <leader>y "+y
nmap <leader>Y gg"+yG
xmap ga <Plug>(EasyAlign)
vmap <localleader> :Commentary<cr>

autocmd BufWritePre * :%s/\s\+$//e
