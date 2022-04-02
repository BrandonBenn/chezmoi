(let [gitsigns (require :gitsigns)
      keymap vim.keymap.set]
  (gitsigns.setup)
  (keymap :n :<leader>gl #(gitsigns.toggle_current_line_blame)))
