(local {: set-options 
        : set-mappings
        : command
        : cnoreabbrev 
        } (require :utils))

(set-options {:expandtab true
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
              :completeopt "menuone,noselect,noinsert"})

(set-mappings [:n ";" ":" {:silent false}]
              [:v ";" ":" {:silent false}]
              [:v :< :<gv]
              [:v :> :>gv]
              [:n :gh :^]
              [:n :gl :$]
              [:n :<C-j> ":cnext<cr>"]
              [:n :<C-k> ":cprev<cr>"]
              [:n :<localleader>w ":update<cr>"]
              [:n :<leader>p "\"+p"]
              [:n :<leader>y "\"+y"]
              [:v :<leader>y "\"+y"]
              [:t :<esc> :<C-\><C-n>]
              [:n :g= ":Format<cr>"])

(command :Format :execute "'lua vim.lsp.buf.formatting()'")
(cnoreabbrev :w :update)
