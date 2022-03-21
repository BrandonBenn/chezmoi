(let [keymap vim.keymap.set]
  (local telescope (require :telescope))
  (local action-layout (require :telescope.actions.layout))
  (local default-picker {:theme :ivy :previewer false})
  (local builtin (require :telescope.builtin))
  (telescope.setup {:defaults {:mappings {:n {:<M-p> action-layout.toggle_preview}
                                          :i {:<M-p> action-layout.toggle_preview}}
                               :file_ignore_patterns [:node_modules]}
                    :extensions {:fzf {:fuzzy true}
                                 {:override_file_sorter true} {:override_generic_sorter true}}
                    :pickers {:live_grep default-picker
                              :find_files default-picker
                              :git_files default-picker
                              :oldfiles default-picker
                              :buffers {:theme :dropdown :previewer false}}})
  (telescope.load_extension :fzf)
  (keymap :n :<C-p> #(when (not (pcall builtin.git_files))
                       (builtin.find_files)))
  (keymap :n :<A-h> #(builtin.oldfiles))
  (keymap :n :<A-g> #(builtin.live_grep))
  (keymap :n :<A-b> #(builtin.buffers))
  (keymap :n :<A-r> #(builtin.resume)))
