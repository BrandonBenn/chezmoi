(local M {})

(λ M.set! [key value]
  "set editor options/globals"
  (if (pcall #(. vim.o key))
      (tset vim.o key value)
      (tset vim.g key value)))

(λ M.map! [mode lhs rhs ?options]
  "Map the key sequence {lhs} to {rhs} for the modes where the map command
  applies. The result, including {rhs}, is then further scanned for mappings."
  (let [options (or ?options {:silent true})]
    (tset options :noremap true)
    (vim.api.nvim_set_keymap mode lhs rhs options)))

(λ M.wrapper [...]
  "wraps vim commands"
  (let [command (.. (table.concat [...] " "))]
    (vim.cmd command)))

(λ M.command [...]
  "Define a user command."
  (M.wrapper :command! ...))

(λ M.colorscheme! [name]
  "Load color scheme {name}."
  (M.wrapper :colorscheme name))

(λ M.cnoreabbrev [lhs rhs]
  "replace one command name with another."
  (M.wrapper :cnoreabbrev lhs rhs))

(λ M.for-each [proc list]
  "Apply {proc} to each element of {list}."
  (when (> (length list) 0)
    (each [_ item (pairs list)]
      (proc item))))

(λ M.for-each-pair [proc tbl]
  "Apply {proc} to each pair of {tbl}."
  (each [key value (pairs tbl)]
    (proc key value)))

M

