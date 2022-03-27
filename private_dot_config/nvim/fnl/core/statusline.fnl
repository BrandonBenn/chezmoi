(set vim.o.statusline (table.concat [" %#NonText#"
                                     "%#Constant#"
                                     " %{expand('%:t')}"
                                     "%#Normal#"
                                     "%m"
                                     "%="
                                     "%l:%c "
                                     "%{&filetype}"
                                     " %#NonText# "]))
