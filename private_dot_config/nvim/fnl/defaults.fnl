(local {: set! : map! : command : cnoreabbrev : for-each-pair} (require :utils))

(for-each-pair set!
               {:expandtab true
                :exrc true
                :hidden true
                :laststatus 0
                :mapleader " "
                :number true
                :relativenumber true
                :scrolloff 999
                :shiftwidth 4
                :showmode false
                :smartcase true
                :smartindent true
                :softtabstop 4
                :spell true
                :spelllang :en
                :spelloptions :camel
                :swapfile false
                :tabstop 4
                :termguicolors true
                :title true
                :udir :/tmp/nvim/undo
                :undofile true
                :wrap false
                :completeopt "menuone,noselect,noinsert"})

(let [mappings [[:n ";" ":" {:silent false}]
                [:v ";" ":" {:silent false}]
                [:v "<" :<gv]
                [:v ">" :>gv]
                [:n :Q :gq]
                [:v :Q :gq]
                [:n :H "^"]
                [:n :L "$"]
                [:n :<C-j> ":cnext<cr>"]
                [:n :<C-k> ":cprev<cr>"]
                [:n :<leader>w ":update<cr>"]
                [:n :<leader>p "\"+p"]
                [:n :<leader>y "\"+y"]
                [:v :<leader>y "\"+y"]
                [:t :<esc> "<C-\\><C-n>"]
                [:n :g= ":Format<cr>"]]]
  (each [_ mapping (pairs mappings)]
    (map! (unpack mapping))))

(command :Format :execute "'lua vim.lsp.buf.formatting()'")
(cnoreabbrev :w :update)

