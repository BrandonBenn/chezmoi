(let [colorscheme #(vim.cmd (.. :colorscheme " " $1))
      cnoreabbrev #(vim.cmd (.. :cnoreabbrev " " $1 $2))
      keymap vim.keymap.set
      o vim.opt
      g vim.g]
  (colorscheme :typograph)
  (set g.mapleader " ")
  (set o.expandtab true)
  (set o.exrc true)
  (set o.hidden true)
  (set o.laststatus 3)
  (set o.number true)
  (set o.relativenumber true)
  (set o.scrolloff 999)
  (set o.shiftwidth 4)
  (set o.showmode true)
  (set o.smartcase true)
  (set o.smartindent true)
  (set o.softtabstop 4)
  (set o.spell true)
  (set o.spelloptions :camel)
  (set o.swapfile false)
  (set o.tabstop 4)
  (set o.termguicolors true)
  (set o.title true)
  (set o.udir :/tmp/nvim/undo)
  (set o.undofile true)
  (set o.wildoptions :pum)
  (set o.wrap false)
  (set o.guifont "JetBrains Mono")
  (set o.completeopt [:menuone :noselect :noinsert])
  (set o.wildmode [:longest :list])
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
  (vim.api.nvim_create_autocmd :TermOpen
                               {:callback #(do
                                             (set vim.wo.relativenumber false)
                                             (set vim.wo.number false))})
  (let [gui (require :core/gui)]
    (gui.setup {:fontsize 12})
    (keymap :n :<C-=> #(gui.resize-font 2))
    (keymap :n :<C--> #(gui.resize-font -2))
    (when (= (vim.fn.executable :nvr) 1)
      (let [editor-command "nvr -cc split --remote-wait"]
        (vim.fn.setenv :EDITOR editor-command)
        (vim.fn.setenv :GIT_EDITOR editor-command)))))
