(require :defaults)
(local {: colorscheme! } (require :utils))

(let [paq (require :paq)]
  (paq
    [
     {:url "https://gitlab.com/th3lusive/typography.vim.git"}
     {1 :ms-jpq/coq.artifacts :branch :artifacts}
     {1 :ms-jpq/coq.thirdparty :branch :3p}
     {1 :ms-jpq/coq_nvim :branch :coq} ; Manually run :COQdeps
     :tpope/vim-eunuch
     :windwp/nvim-autopairs
     :neovim/nvim-lspconfig
     :akinsho/bufferline.nvim
     :numToStr/Comment.nvim
     :jose-elias-alvarez/null-ls.nvim

     ;; plugins used by others
     :nvim-lua/plenary.nvim
     :nvim-lua/popup.nvim
     :savq/paq-nvim ; let paq manage itself
     ]))

(colorscheme! :typograph)

(require :plugins/nvim-autopairs)
(require :plugins/coq_nvim)
(require :plugins/lspconfig)
(require :plugins/bufferline)
(require :plugins/comment)
(require :plugins/null-ls)
