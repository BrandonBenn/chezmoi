;; Plugins managed by paq-nvim
(let [paq (require :paq)]
  (paq [{1 :nvim-treesitter/nvim-treesitter :run #(vim.cmd :TSUpdate)}
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
        :justinmk/vim-dirvish
        :roginfarrer/vim-dirvish-dovish
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
