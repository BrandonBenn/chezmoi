(local {: map! : command} (require :core/utils))

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

(fn _G.project_files []
  (let [ok (pcall builtin.git_files)]
    (when (not ok)
      (builtin.find_files))))

(command :ProjectFiles :execute "'lua project_files()'")
(map! :n :<C-p> ":ProjectFiles<cr>")
(map! :n :<A-h> ":Telescope oldfiles<cr>")
(map! :n :<A-g> ":Telescope live_grep<cr>")
(map! :n :<A-b> ":Telescope buffers<cr>")
(map! :n :<A-r> ":Telescope resume<cr>")
