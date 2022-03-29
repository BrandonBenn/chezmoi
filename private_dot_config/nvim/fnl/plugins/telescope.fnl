(let [keymap vim.keymap.set
      autocmd vim.api.nvim_create_autocmd
      telescope (require :telescope)
      actions (require :telescope.actions)
      builtin (require :telescope.builtin)
      layout (require :telescope.actions.layout)]
  (telescope.setup {:defaults {:layout_strategy :center
                               :results_title false
                               :sorting_strategy :ascending
                               :preview {:hide_on_startup true}
                               :borderchars {:prompt ["─" "│" " " "│" "╭" "╮" "│" "│"]
                                             :results ["─" "│" "─" "│" "├" "┤" "╯" "╰"]
                                             :preview ["─" "│" "─" "│" "╭" "╮" "╯" "╰"]}
                               :path_display [:smart]
                               :mappings {:n {:<M-p> layout.toggle_preview}
                                          :i {:<M-p> layout.toggle_preview
                                              :<c-d> actions.delete_buffer}}
                               :file_ignore_patterns [:node_modules]}
                    :extensions {:fzf {:fuzzy true}
                                 {:override_file_sorter true} {:override_generic_sorter true}}})
  (telescope.load_extension :fzf)
  (keymap :n :<C-p> #(when (not (pcall builtin.git_files))
                       (builtin.find_files)))
  (keymap :n :<A-h> #(builtin.oldfiles))
  (keymap :n :<A-r> #(builtin.resume))
  (keymap :n :<A-b> #(builtin.buffers))
  (keymap :n :<A-g>g #(builtin.live_grep))
  (keymap :n :<A-g>w #(builtin.grep_string)))
