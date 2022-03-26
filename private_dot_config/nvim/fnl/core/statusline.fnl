(let [highlight #(vim.api.nvim_set_hl 0 $...)]
  (highlight :PrimaryBlock {:ctermfg 6 :ctermbg 0})
  (highlight :SecondaryBlock {:ctermfg 5 :ctermbg 0})
  (highlight :Blanks {:ctermfg 7 :ctermbg 0}))

(set vim.o.statusline (table.concat ["%#PrimaryBlock#"
                                     "%#SecondaryBlock#"
                                     "%#Blanks#"
                                     "%f"
                                     "%m"
                                     "%="
                                     "%#SecondaryBlock#"
                                     "%l:%c "
                                     "%#PrimaryBlock#"
                                     "%{&filetype}"]))
