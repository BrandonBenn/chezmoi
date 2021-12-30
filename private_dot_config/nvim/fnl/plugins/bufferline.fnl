(local {: map! : set!} (require :core/utils))
(let [bufferline (require :bufferline)]
  ((. bufferline :setup) {}))

(set! :termguicolors true)
(map! :n :<tab> ":bn<cr>")
(map! :n :<S-tab> ":bp<cr>")

