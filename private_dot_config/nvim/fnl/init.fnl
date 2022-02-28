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
        :jose-elias-alvarez/null-ls.nvim
        :norcalli/nvim-colorizer.lua
        :neovim/nvim-lspconfig
        :numToStr/Comment.nvim
        :lukas-reineke/indent-blankline.nvim
        :nvim-telescope/telescope.nvim
        {1 :nvim-telescope/telescope-fzf-native.nvim :run :make}
        :kyazdani42/nvim-web-devicons
        :projekt0n/circles.nvim
        :projekt0n/github-nvim-theme
        :tpope/vim-eunuch
        :tpope/vim-vinegar
        :skywind3000/asyncrun.vim
        :TimUntersberger/neogit
        :windwp/nvim-autopairs
        :ethanholz/nvim-lastplace
        :janet-lang/janet.vim
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

(set! :gitblame_enabled 0)
(let [lastplace (require :nvim-lastplace)]
  (lastplace.setup))

(require :impatient)
(set vim.g.copilot_filetypes {:TelescopePrompt false})

(let [circles (require :circles)]
  (circles.setup {:lsp true}))

(set vim.g.nnn#layout {:window {:width 0.3 :height 0.5}})
;; Configurations that are not managed by version control
(pcall #(require :local))
