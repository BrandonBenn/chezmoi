(require :defaults)
(local {: colorscheme! : require-all } (require :utils))

;; Plugsins managed by paq-nvim
(let [paq (require :paq)]
  (paq [{:url "https://gitlab.com/th3lusive/typography.vim.git"}
        {1 :ms-jpq/coq.artifacts :branch :artifacts}
        {1 :ms-jpq/coq.thirdparty :branch :3p}
        {1 :ms-jpq/coq_nvim :branch :coq} ; Manually run :COQdeps
        :tpope/vim-eunuch
        :windwp/nvim-autopairs
        :neovim/nvim-lspconfig
        :akinsho/bufferline.nvim
        :numToStr/Comment.nvim
        :jose-elias-alvarez/null-ls.nvim
        :nvim-telescope/telescope.nvim
        :ziglang/zig.vim

        ;; plugins used by others
        :nvim-lua/plenary.nvim
        :nvim-lua/popup.nvim
        ; let paq manage itself
        :savq/paq-nvim]))

(colorscheme! :typograph)

(require-all :plugins/bufferline
             :plugins/comment
             :plugins/coq_nvim
             :plugins/lspconfig
             :plugins/null-ls
             :plugins/telescope
             :plugins/nvim-autopairs)
