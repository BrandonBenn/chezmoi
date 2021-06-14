let mapleader = " "
let maplocalleader = ";"

set termguicolors | color bruin
set noshowmode noruler laststatus=0 noshowcmd cmdheight=1
set backspace=indent,eol,start
set relativenumber number
set autochdir

autocmd BufWritePre * :%s/\s\+$//e

command! Buffers Telescope buffers
command! Finder  Telescope file_browser
command! Files   Telescope find_files
command! Grep    Telescope live_grep

nmap H ^
nmap L $
nmap <localleader>; :update<cr>
nmap <localleader>bd :bd<cr>
nmap <localleader>noh :noh<cr>
nmap <localleader>q :q<cr>
nmap <Leader>R :runtime! ~/.config/nvim/*/*<cr>
nmap <Leader>b :Buffers<cr>
nmap <C-p> :Files<cr>
nmap <Leader>g :Goyo<cr>
nmap <leader>y "+y
nmap <leader>Y gg"+yG
nmap <leader>p "+p
xmap ga <Plug>(EasyAlign)
vmap <localleader> :Commentary<cr>
