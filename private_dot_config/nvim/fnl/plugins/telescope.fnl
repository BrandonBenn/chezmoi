(let [keymap vim.keymap.set
      autocmd vim.api.nvim_create_autocmd
      telescope (require :telescope)
      actions (require :telescope.actions)
      builtin (require :telescope.builtin)
      layout (require :telescope.actions.layout)
      default-picker {:theme :dropdown :previewer false}]
  (telescope.setup {:defaults {:path_display [:truncate]
                               :mappings {:n {:<M-p> layout.toggle_preview}
                                          :i {:<M-p> layout.toggle_preview
                                              :<c-d> actions.delete_buffer}}
                               :file_ignore_patterns [:node_modules]}
                    :extensions {:fzf {:fuzzy true}
                                 {:override_file_sorter true} {:override_generic_sorter true}}
                    :pickers {:live_grep default-picker
                              :find_files default-picker
                              :git_files default-picker
                              :oldfiles default-picker
                              :buffers default-picker}})
  (telescope.load_extension :fzf)
  (keymap :n :<C-p> #(when (not (pcall builtin.git_files))
                       (builtin.find_files)))
  (keymap :n :<A-h> #(builtin.oldfiles))
  (keymap :n :<A-r> #(builtin.resume))
  (keymap :n :<A-g> #(builtin.live_grep))
  (keymap :n :<A-b> #(builtin.buffers)))
