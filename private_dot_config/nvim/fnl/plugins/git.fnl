(let [neogit (require :neogit)
      keymap vim.keymap.set]
  (neogit.setup {:disable_builtin_notifications true
                 :integrations {:diffview true}})
  (keymap :n :<leader>gg #(neogit.open)))

(let [gitsigns (require :gitsigns)
      keymap vim.keymap.set]
  (gitsigns.setup)
  (keymap :n :<leader>gl #(gitsigns.toggle_current_line_blame)))

(let [diffview (require :diffview)]
  (diffview.setup {:use_icons false}))
