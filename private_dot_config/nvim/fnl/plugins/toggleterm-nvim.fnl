(let [toggleterm (require :toggleterm)]
  (toggleterm.setup {:open_mapping :<c-\>
                     :size 30
                     :hide_numbers true
                     :close_on_exit true}))
