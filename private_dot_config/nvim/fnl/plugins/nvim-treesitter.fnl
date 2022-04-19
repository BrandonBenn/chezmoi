(let [treesitter (require :nvim-treesitter.configs)]
  (treesitter.setup {:ensure_installed [:ruby :lua :vue :fennel]
                     :sync_install true
                     :highlight {:enable true
                                 :additional_vim_regex_highlighting false}}))
