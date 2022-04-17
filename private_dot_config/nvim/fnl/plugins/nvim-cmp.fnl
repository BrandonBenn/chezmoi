(let [cmp (require :cmp)]
  (cmp.setup {:snippet {:expand (fn [args]
                                  ((. vim.fn "vsnip#anonymous") args.body))}
              :mapping {:<C-b> (cmp.mapping (cmp.mapping.scroll_docs (- 4))
                                            [:i :c])
                        :<C-f> (cmp.mapping (cmp.mapping.scroll_docs 4) [:i :c])
                        :<C-y> (cmp.mapping (cmp.mapping.complete) [:i :c])
                        :<C-e> (cmp.mapping {:i (cmp.mapping.abort)
                                             :c (cmp.mapping.close)})
                        :<CR> (cmp.mapping.confirm {:select true})}
              :sources (cmp.config.sources [{:name :nvim_lsp} {:name :vsnip}]
                                           [{:name :buffer
                                             :option {:get_bufnrs #(vim.api.nvim_list_bufs)}}])}))
