(require :core/defaults)

(local {: set! : for-each : colorscheme!} (require :core/utils))
(local f vim.fn)

;; Plugins managed by paq-nvim
(let [paq (require :paq)]
  (paq [;; Manually run :COQdeps
        {1 :ms-jpq/coq.artifacts :branch :artifacts}
        {1 :ms-jpq/coq.thirdparty :branch :3p}
        {1 :ms-jpq/coq_nvim :branch :coq}
        :gelguy/wilder.nvim
        :akinsho/bufferline.nvim
        :f-person/git-blame.nvim
        :github/copilot.vim
        :jghauser/mkdir.nvim
        :jose-elias-alvarez/null-ls.nvim
        :neovim/nvim-lspconfig
        :numToStr/Comment.nvim
        :nvim-telescope/telescope.nvim
        :tpope/vim-eunuch
        :hkupty/iron.nvim
        :windwp/nvim-autopairs
        :ethanholz/nvim-lastplace
        :janet-lang/janet.vim
        :ziglang/zig.vim
        ;; plugins used by others
        :nvim-lua/popup.nvim
        :nvim-lua/plenary.nvim
        ;; let paq manage itself
        :savq/paq-nvim]))

(for-each require [:mkdir
                   :plugins/bufferline
                   :plugins/comment
                   :plugins/coq_nvim
                   :plugins/lspconfig
                   :plugins/null-ls
                   :plugins/telescope
                   :plugins/coq
                   :plugins/iron
                   :plugins/nvim-autopairs])

(set! :gitblame_enabled 0)
(let [lastplace (require :nvim-lastplace)]
  (lastplace.setup))

(f.wilder#setup {:modes [":" "/" "?"]})

;; Configurations that are not managed by version control
(pcall #(require :local))

