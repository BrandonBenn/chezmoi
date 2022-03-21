(fn set-font [family ?size]
  "Set the font to FAMILY at SIZE."
  (set vim.g.guifontsize (or ?size vim.g.guifontsize))
  (set vim.o.guifont (.. family ":h" vim.g.guifontsize)))

(fn resize-font [size]
  "Resize the font size by SIZE."
  (set vim.g.guifontsize (+ vim.g.guifontsize size))
  (set-font vim.o.guifont vim.g.guifontsize))

(fn setup [args]
  (tset vim.g :guifontsize args.fontsize))

{: setup : resize-font}
