(local {: map! : set!} (require :utils))
(let [bufferline (require :bufferline)]
  ((. bufferline :setup) {}))

(set! :termguicolors true)
(map! :n :<tab> ":bn<cr>")
(map! :n :<S-tab> ":bp<cr>")

