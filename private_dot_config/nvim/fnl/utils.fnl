(λ set! [key value]
  "set editor options/globals"
    (if (pcall #(. vim.o key))
      (tset vim.o key value)
      (tset vim.g key value)))

(λ set-options [options]
  "set a table of editor options at once."
  (each [key value (pairs options)]
    (set! key value)))

(λ map! [mode lhs rhs ?options]
  "Map the key sequence {lhs} to {rhs} for the modes where the map command
  applies. The result, including {rhs}, is then further scanned for mappings."
  (let [options (or ?options {})]
    (tset options :noremap true)
        (vim.api.nvim_set_keymap mode lhs rhs options)))

(λ colorscheme! [name]
  "Load color scheme {name}."
  (vim.cmd (.. "colorscheme " name)))

{
 : set!
 : map!
 : colorscheme!
 : set-options
}
