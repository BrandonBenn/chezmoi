(local {: set! : map! : colorscheme! : command : cnoreabbrev : for-each-pair}
       (require :core/utils))

(colorscheme! :typograph)
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
                :guifont "JetBrains Mono"
                :completeopt "menuone,noselect,noinsert"})

(let [mappings [[:n ";" ":"]
                [:v ";" ":"]
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

(let [gui (require :core/gui)]
  (gui.setup {:fontsize 11})
  (map! :n :<C-=> ":IncreaseFont<cr>")
  (map! :n :<C--> ":DecreaseFont<cr>"))

