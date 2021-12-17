(local {: set-options 
        : map! 
        } (require :utils))

(set-options 
  {
   :expandtab true
   :exrc true
   :hidden true
   :laststatus 0
   :mapleader " "
   :number true
   :number true
   :relativenumber true
   :relativenumber true
   :scrolloff 999
   :shiftwidth 4
   :showmode false
   :smartindent true
   :softtabstop 4
   :swapfile false
   :tabstop 4
   :termguicolors true
   :title true
   :udir "/tmp/nvim/undo"
   :undofile true
   :wrap false
   :completeopt "menuone,noselect,noinsert"
   })

(map! :n ";" ":")
(map! :v ";" ":")
(map! :v :< :<gv)
(map! :v :> :>gv)
(map! :n :gh :^)
(map! :n :gl :$)
(map! :n :<C-j> ":cnext<cr>")
(map! :n :<C-k> ":cprev<cr>")
(map! :n :<localleader>w ":update<cr>")
(map! :n :<leader>p "\"+p")
(map! :n :<leader>y "\"+y")
(map! :v :<leader>y "\"+y")
(map! :t :<esc> :<C-\><C-n>)
