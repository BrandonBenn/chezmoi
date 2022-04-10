(set _G.notes_dir "~/Sync/20-29-Personal/20-Notes/")
(set _G.daily_notes_dir :daily)
(set _G.notes_ext :md)

(vim.api.nvim_add_user_command :DailyNote
                               #(let [note-file (string.format "%s%s/%s.%s"
                                                               notes_dir
                                                               daily_notes_dir
                                                               (os.date "%Y-%m-%d")
                                                               notes_ext)]
                                  (vim.cmd (.. "edit " note-file)))
                               {})
