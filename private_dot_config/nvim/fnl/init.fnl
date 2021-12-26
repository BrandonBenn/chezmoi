(require :defaults)
(local {: colorscheme! : set!} (require :utils))
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
        :janet-lang/janet.vim
        :ziglang/zig.vim
        ;; plugins used by others
        :nvim-lua/popup.nvim
        :nvim-lua/plenary.nvim
        ;; let paq manage itself
        :savq/paq-nvim]))

(let [mod [:mkdir
           :plugins/bufferline
           :plugins/comment
           :plugins/coq_nvim
           :plugins/lspconfig
           :plugins/null-ls
           :plugins/telescope
           :plugins/iron
           :plugins/nvim-autopairs]]
  (each [_ value (pairs mod)]
    (require value)))

(colorscheme! :typograph)
(set! :gitblame_enabled 0)
(f.wilder#setup {:modes [":" "/" "?"]})
(let [coq_3p (require :coq_3p)]
  (coq_3p [{:src :repl :sh :bash :max_lines 99 :deadline 900}
           {:src :copilot :short_name :COP :tmp_accept_key :<c-r>}]))
