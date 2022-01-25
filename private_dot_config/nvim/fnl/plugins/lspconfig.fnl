(let [nvim-lsp (require :lspconfig)]
  (fn on-attach [client buffer]
    (fn buf-map! [...]
      (vim.api.nvim_buf_set_keymap buffer ...))

    (fn buf-set-option [...]
      (vim.api.nvim_buf_set_option buffer ...))

    (buf-set-option :omnifunc "v:lua.vim.lsp.omnifunc")
    (let [o {:noremap true :silent true}]
      (buf-map! :n :gD ":lua vim.lsp.buf.declaration()<CR>" o)
      (buf-map! :n :gd ":lua vim.lsp.buf.definition()<CR>" o)
      (buf-map! :n :K ":lua vim.lsp.buf.hover()<CR>" o)
      (buf-map! :n :gi ":lua vim.lsp.buf.implementation()<CR>" o)
      (buf-map! :n :<C-k> ":lua vim.lsp.buf.signature_help()<CR>" o)
      (buf-map! :n :<leader>wa ":lua vim.lsp.buf.add_workspace_folder()<CR>" o)
      (buf-map! :n :<leader>wr ":lua vim.lsp.buf.remove_workspace_folder()<CR>"
                o)
      (buf-map! :n :<leader>wl
                ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>"
                o)
      (buf-map! :n :<leader>D ":lua vim.lsp.buf.type_definition()<CR>" o)
      (buf-map! :n :<leader>rn ":lua vim.lsp.buf.rename()<CR>" o)
      (buf-map! :n :<leader>ca ":lua vim.lsp.buf.code_action()<CR>" o)
      (buf-map! :n :gr ":lua vim.lsp.buf.references()<CR>" o)
      (buf-map! :n :<leader>e ":lua vim.diagnostic.open_float()<CR>" o)
      (buf-map! :n "[d" ":lua vim.diagnostic.goto_prev()<CR>" o)
      (buf-map! :n "]d" ":lua vim.diagnostic.goto_next()<CR>" o)
      (buf-map! :n :<leader>q ":lua vim.diagnostic.setloclist()<CR>" o)
      (buf-map! :n :<leader>f ":lua vim.lsp.buf.formatting()<CR>" o)))

  (let [servers [:solargraph :zls :vls :clangd :zk]]
    (each [_ lsp (ipairs servers)]
      ((. (. nvim-lsp lsp) :setup) {:on_attach on-attach
                                    :flags {:debounce_text_changes 150}}))))

