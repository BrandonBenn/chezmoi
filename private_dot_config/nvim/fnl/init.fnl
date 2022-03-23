;; Plugins managed by paq-nvim
(let [paq (require :paq)]
  (paq [;; Manually run :COQdeps
        {1 :nvim-treesitter/nvim-treesitter :run #(vim.cmd :TSUpdate)}
        :hrsh7th/cmp-nvim-lsp
        :hrsh7th/cmp-cmdline
        :hrsh7th/cmp-buffer
        :hrsh7th/cmp-vsnip
        :hrsh7th/vim-vsnip
        :hrsh7th/nvim-cmp
        :hrsh7th/cmp-path
        :github/copilot.vim
        :jghauser/mkdir.nvim
        :famiu/bufdelete.nvim
        :jose-elias-alvarez/null-ls.nvim
        :norcalli/nvim-colorizer.lua
        :neovim/nvim-lspconfig
        :numToStr/Comment.nvim
        :lukas-reineke/indent-blankline.nvim
        :nvim-telescope/telescope.nvim
        {1 :nvim-telescope/telescope-fzf-native.nvim :run :make}
        :folke/zen-mode.nvim
        :akinsho/toggleterm.nvim
        :tpope/vim-eunuch
        :tpope/vim-vinegar
        :windwp/nvim-autopairs
        :ethanholz/nvim-lastplace
        :lewis6991/impatient.nvim
        :ziglang/zig.vim
        :kchmck/vim-coffee-script
        ;; plugins used by others
        :nvim-lua/popup.nvim
        :nvim-lua/plenary.nvim
        ;; let paq manage itself
        :savq/paq-nvim]))

(let [modules [:mkdir
               :impatient
               :core/defaults
               :plugins/comment
               :plugins/lspconfig
               :plugins/nvim-cmp
               :plugins/toggleterm-nvim
               :plugins/null-ls
               :plugins/telescope
               :plugins/nvim-autopairs]]
  (each [_ module (pairs modules)]
    (require module)))

(let [lastplace (require :nvim-lastplace)]
  (lastplace.setup))

(set vim.g.copilot_filetypes {:TelescopePrompt false :markdown true})

(pcall #(require :local))
