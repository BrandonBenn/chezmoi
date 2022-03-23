(let [servers [:solargraph :zls :clangd]
      nvim-lsp (require :lspconfig)
      flags {:debounce_text_changes 150}
      keymap #(vim.keymap.set $2 $3 $4 {:noremap true :silent true :buffer $1})
      capabilities ((. (require :cmp_nvim_lsp) :update_capabilities) (vim.lsp.protocol.make_client_capabilities))
      on-attach (fn [client buf]
                  "Set the keymap and attach the client."
                  (set vim.bo.omnifunc "v:lua.vim.lsp.omnifunc")
                  (keymap buf :n :gd #(vim.lsp.buf.definition))
                  (keymap buf :n :gD #(vim.lsp.buf.declaration))
                  (keymap buf :n :K #(vim.lsp.buf.hover))
                  (keymap buf :n :gi #(vim.lsp.buf.implementation))
                  (keymap buf :n :<C-k> #(vim.lsp.buf.signature_help))
                  (keymap buf :n :<leader>wa
                          #(vim.lsp.buf.add_workspace_folder))
                  (keymap buf :n :<leader>wr
                          #(vim.lsp.buf.remove_workspace_folder))
                  (keymap buf :n :<leader>wl
                          #(print (vim.inspect (vim.lsp.buf.list_workspace_folders))))
                  (keymap buf :n :<leader>D #(vim.lsp.buf.type_definition))
                  (keymap buf :n :<leader>rn #(vim.lsp.buf.rename))
                  (keymap buf :n :<leader>ca #(vim.lsp.buf.code_action))
                  (keymap buf :n :gr #(vim.lsp.buf.references))
                  (keymap buf :n :<leader>e #(vim.diagnostic.open_float))
                  (keymap buf :n "[d" #(vim.diagnostic.goto_prev))
                  (keymap buf :n "]d" #(vim.diagnostic.goto_next))
                  (keymap buf :n :<leader>q #(vim.diagnostic.setloclist))
                  (keymap buf :n :<leader>f #(vim.lsp.buf.formatting)))]
  (each [_ lsp (ipairs servers)]
    ((. (. nvim-lsp lsp) :setup) {:on_attach on-attach : flags : capabilities})))
