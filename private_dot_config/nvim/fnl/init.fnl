(let [modules [:deps
               :mkdir
               :impatient
               :core/defaults
               :plugins/comment
               :plugins/lspconfig
               :plugins/nvim-cmp
               :plugins/toggleterm-nvim
               :plugins/null-ls
               :plugins/gitsigns
               :plugins/telescope
               :plugins/nvim-autopairs]]
  (each [_ module (pairs modules)]
    (require module)))

(let [lastplace (require :nvim-lastplace)]
  (lastplace.setup))

(vim.cmd "cnoreabbrev bd Bdelete")

(vim.keymap.set :n :<LocalLeader>bdb ":Bdelete<cr>")

(set vim.g.copilot_filetypes {:TelescopePrompt false :markdown true})

(pcall #(require :local))
