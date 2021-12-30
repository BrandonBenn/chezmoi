(local {: set! : for-each : colorscheme!} (require :core/utils))
(require :core/defaults)

(local f vim.fn)

;; Plugsins managed by paq-nvim
(let [paq (require :paq)]
  (paq [{:url "https://gitlab.com/th3lusive/typography.vim.git"}
        ;; Manually run :COQdeps
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

(colorscheme! :typograph)
(set! :gitblame_enabled 0)
(let [lastplace (require :nvim-lastplace)]
  (lastplace.setup))

(f.wilder#setup {:modes [":" "/" "?"]})

(pcall #(require :local))

