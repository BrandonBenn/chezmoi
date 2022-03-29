(let [keymap vim.keymap.set
      autocmd vim.api.nvim_create_autocmd
      telescope (require :telescope)
      actions (require :telescope.actions)
      builtin (require :telescope.builtin)
      themes (require :telescope.themes)
      layout (require :telescope.actions.layout)
      merge #(vim.tbl_deep_extend :force $1 $2)]
  (telescope.setup {:defaults (merge (themes.get_dropdown)
                                     {:preview {:hide_on_startup true}
                                      :path_display [:smart]
                                      :mappings {:n {:<M-p> layout.toggle_preview}
                                                 :i {:<M-p> layout.toggle_preview
                                                     :<c-d> actions.delete_buffer}}
                                      :file_ignore_patterns [:node_modules]})
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
