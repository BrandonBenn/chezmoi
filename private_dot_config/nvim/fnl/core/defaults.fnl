(let [colorscheme #(vim.cmd (.. :colorscheme " " $1))
      cnoreabbrev #(vim.cmd (.. :cnoreabbrev " " $1 $2))
      keymap vim.keymap.set]
  (colorscheme :typograph)
  (set vim.g.mapleader " ")
  (set vim.o.expandtab true)
  (set vim.o.exrc true)
  (set vim.o.hidden true)
  (set vim.o.laststatus 0)
  (set vim.o.number true)
  (set vim.o.relativenumber true)
  (set vim.o.scrolloff 999)
  (set vim.o.shiftwidth 4)
  (set vim.o.showmode false)
  (set vim.o.smartcase true)
  (set vim.o.smartindent true)
  (set vim.o.softtabstop 4)
  (set vim.o.spell true)
  (set vim.o.spelloptions :camel)
  (set vim.o.swapfile false)
  (set vim.o.tabstop 4)
  (set vim.o.termguicolors true)
  (set vim.o.title true)
  (set vim.o.udir :/tmp/nvim/undo)
  (set vim.o.undofile true)
  (set vim.o.wildmode "longest,list")
  (set vim.o.wildoptions :pum)
  (set vim.o.wrap false)
  (set vim.o.guifont "JetBrains Mono")
  (set vim.o.completeopt "menuone,noselect,noinsert")
  (let [options {:silent true :noremap true}
        mappings [[:v "<" :<gv]
                  [:v ">" :>gv]
                  [[:n :v] :Q :gq]
                  [[:n :v] ";" ":"]
                  [[:n :v] :<leader>y "\"+y"]
                  [:n :<leader>p "\"+p"]
                  [:t :<esc> "<C-\\><C-n>"]
                  [:n :g= #(vim.lsp.buf.formatting)]]]
    (each [_ mapping (pairs mappings)]
      (let [(mode lhs rhs) (unpack mapping)]
        (keymap mode lhs rhs options))))
  (let [gui (require :core/gui)]
    (gui.setup {:fontsize 12})
    (keymap :n :<C-=> #(gui.resize-font 2))
    (keymap :n :<C--> #(gui.resize-font -2))
    (when (= (vim.fn.executable :nvr) 1)
      (let [editor-command "nvr -cc split --remote-wait"]
        (vim.fn.setenv :EDITOR editor-command)
        (vim.fn.setenv :GIT_EDITOR editor-command)))))
