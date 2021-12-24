(require :defaults)
(local {: colorscheme! : require-all : set! } (require :utils))

;; Plugsins managed by paq-nvim
(let [paq (require :paq)]
  (paq [{:url "https://gitlab.com/th3lusive/typography.vim.git"}
        {1 :ms-jpq/coq.artifacts :branch :artifacts}
        {1 :ms-jpq/coq.thirdparty :branch :3p}
        {1 :ms-jpq/coq_nvim :branch :coq} ; Manually run :COQdeps
        :akinsho/bufferline.nvim
        :f-person/git-blame.nvim
        :github/copilot.vim
        :jghauser/mkdir.nvim
        :jose-elias-alvarez/null-ls.nvim
        :neovim/nvim-lspconfig
        :numToStr/Comment.nvim
        :nvim-telescope/telescope.nvim
        :tpope/vim-eunuch
        :windwp/nvim-autopairs
        :ziglang/zig.vim

        ;; plugins used by others
        :nvim-lua/popup.nvim :nvim-lua/plenary.nvim
        ; let paq manage itself
        :savq/paq-nvim]))

(require-all :plugins/bufferline
             :plugins/comment
             :plugins/coq_nvim
             :plugins/lspconfig
             :plugins/null-ls
             :plugins/telescope
             :plugins/nvim-autopairs)

(colorscheme! :typograph)
(set! :gitblame_enabled 0)

(require :mkdir)
