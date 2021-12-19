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

(λ M.require-all [...]
  "set a table of editor options at once."
  (each [_ value (pairs [...])]
    (require value)))

(λ M.set-options [options]
  "set a table of editor options at once."
  (each [key value (pairs options)]
    (M.set! key value)))

(λ M.set-mappings [...]
  "set a table of editor mappings at once."
  (each [_ mapping (pairs [...])]
    (M.map! (unpack mapping))))

(λ wrapper [...]
  "wraps vim commands"
  (let [command (.. (table.concat [...] " "))]
    (vim.cmd command)))

(λ M.command [...]
  "Define a user command."
  (wrapper :command! ...))

(λ M.colorscheme! [name]
  "Load color scheme {name}."
  (wrapper :colorscheme name))

(λ M.cnoreabbrev [lhs rhs]
  "replace one command name with another."
  (wrapper :cnoreabbrev lhs rhs))

M ; export
