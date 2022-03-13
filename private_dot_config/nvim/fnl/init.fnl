(require :core/defaults)

(local {: set! : map! : for-each : colorscheme!} (require :core/utils))
(local f vim.fn)

;; Plugins managed by paq-nvim
(let [paq (require :paq)]
  (paq [;; Manually run :COQdeps
        {1 :ms-jpq/coq.artifacts :branch :artifacts}
        {1 :ms-jpq/coq.thirdparty :branch :3p}
        {1 :ms-jpq/coq_nvim :branch :coq}
        {1 :nvim-treesitter/nvim-treesitter
         :run (λ []
                (vim.cmd :TSUpdate))}
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
        :tpope/vim-eunuch
        :tpope/vim-vinegar
        :windwp/nvim-autopairs
        :ethanholz/nvim-lastplace
        :alexghergh/nvim-tmux-navigation
        :lewis6991/impatient.nvim
        :ziglang/zig.vim
        :kchmck/vim-coffee-script
        ;; plugins used by others
        :nvim-lua/popup.nvim
        :nvim-lua/plenary.nvim
        ;; let paq manage itself
        :savq/paq-nvim]))

(for-each require [:mkdir
                   :plugins/comment
                   :plugins/coq_nvim
                   :plugins/lspconfig
                   :plugins/null-ls
                   :plugins/telescope
                   :plugins/nvim-autopairs])

(let [lastplace (require :nvim-lastplace)]
  (lastplace.setup))

(require :impatient)
(set vim.g.copilot_filetypes {:TelescopePrompt false :markdown true})

(let [nvim-tmux-navigation (require :nvim-tmux-navigation)]
  (nvim-tmux-navigation.setup {:disable_when_zoomed true
                               :keybindings {:left :<C-h>
                                             :down :<C-j>
                                             :up :<C-k>
                                             :right :<C-l>
                                             :last_active "<C-\\>"
                                             :next :<A-Space>}}))

;; Configurations that are not managed by version control
(pcall #(require :local))
