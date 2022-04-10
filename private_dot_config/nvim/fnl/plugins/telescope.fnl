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
                                      :mappings {:n {:<M-p> layout.toggle_preview
                                                     :d actions.delete_buffer}
                                                 :i {:<M-p> layout.toggle_preview
                                                     :<c-d> actions.delete_buffer}}
                                      :file_ignore_patterns [:node_modules]})
                    :extensions {:fzf {:fuzzy true}
                                 {:override_file_sorter true} {:override_generic_sorter true}}})
  (telescope.load_extension :fzf)
  (keymap :n :<C-p> #(when (not (pcall builtin.git_files))
                       (builtin.find_files)))
  (keymap :n :<leader>fo #(builtin.oldfiles))
  (keymap :n :<leader>fr #(builtin.resume))
  (keymap :n :<leader>fb #(builtin.buffers))
  (keymap :n :<leader>fg #(builtin.live_grep))
  (keymap :n :<leader>fw #(builtin.grep_string)))
