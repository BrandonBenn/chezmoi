(let [toggleterm (require :toggleterm)]
  (toggleterm.setup {:open_mapping :<c-t>
                     :size 40
                     :hide_numbers true
                     :close_on_exit true}))

(let [terminal (. (require :toggleterm.terminal) :Terminal)
      gitui (terminal:new {:cmd :gitui :hidden true :direction :float})]
  (vim.keymap.set :n :<leader>gg #(gitui:toggle)))
