(local {: set!
        : map!
        : colorscheme!
        : command
        : autocmd
        : cnoreabbrev
        : for-each-pair} (require :core/utils))

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

(let [options {:silent true}
      mappings [[:v "<" :<gv]
                [:v ">" :>gv]
                [[:n :v] :Q :gq]
                [:n :<leader>w ":update<cr>"]
                [:n :<leader>p "\"+p"]
                [:n :<leader>y "\"+y"]
                [:v :<leader>y "\"+y"]
                [:t :<esc> "<C-\\><C-n>"]
                [:n :g= ":Format<cr>"]]]
  (each [_ mapping (pairs mappings)]
    (let [(mode lhs rhs) (unpack mapping)]
      (vim.keymap.set mode lhs rhs options))))

(autocmd :TermOpen "* setlocal nonumber norelativenumber")
(command :Format :execute "'lua vim.lsp.buf.formatting()'")

(let [gui (require :core/gui)]
  (gui.setup {:fontsize 14})
  (map! :n :<C-=> ":IncreaseFont<cr>")
  (map! :n :<C--> ":DecreaseFont<cr>"))

(when (= (vim.fn.executable :nvr) 1)
  (let [editor-command "nvr -cc split --remote-wait"]
    (vim.fn.setenv :EDITOR editor-command)
    (vim.fn.setenv :GIT_EDITOR editor-command)))
