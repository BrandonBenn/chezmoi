(set vim.o.showmode false)

(fn _G.mode []
  (let [mode (. (vim.api.nvim_get_mode) :mode)
        mode-map {:n "normal "
                  :no "n·operator pending "
                  :v "visual "
                  :V "v·line "
                  "\022" "v·block "
                  :s "select "
                  :S "s·line "
                  "\019" "s·block "
                  :i "insert "
                  :R "replace "
                  :Rv "v·replace "
                  :c "command "
                  :cv "vim ex "
                  :ce "ex "
                  :r "prompt "
                  :rm "more "
                  :r? "confirm "
                  :! "shell "
                  :t "terminal "}]
    (when (= (. mode-map mode) nil)
      (return mode))
    (. mode-map mode)))

(set vim.o.statusline (table.concat [" %#NonText# "
                                     "%{luaeval('mode()')}"
                                     "%#Constant#"
                                     "%{expand('%:t')}"
                                     "%#Normal#"
                                     "%="
                                     "%l:%c"
                                     "%#Constant#"
                                     " %{&filetype}"
                                     " %#NonText#"]))
