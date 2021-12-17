(let [nvim-lsp (require :lspconfig)]
  (fn on-attach [client buffer]
    (fn buf-map! [...]
      (vim.api.nvim_buf_set_keymap buffer ...))

    (fn buf-set-option [...]
      (vim.api.nvim_buf_set_option buffer ...))

    (buf-set-option :omnifunc "v:lua.vim.lsp.omnifunc")
    (let [opts {:noremap true :silent true}]
      (buf-map! :n :gD ":lua vim.lsp.buf.declaration()<CR>" opts)
      (buf-map! :n :gd ":lua vim.lsp.buf.definition()<CR>" opts)
      (buf-map! :n :K ":lua vim.lsp.buf.hover()<CR>" opts)
      (buf-map! :n :gi ":lua vim.lsp.buf.implementation()<CR>" opts)
      (buf-map! :n :<C-k> ":lua vim.lsp.buf.signature_help()<CR>" opts)
      (buf-map! :n :<space>wa ":lua vim.lsp.buf.add_workspace_folder()<CR>" opts)
      (buf-map! :n :<space>wr ":lua vim.lsp.buf.remove_workspace_folder()<CR>" opts)
      (buf-map! :n :<space>wl ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>" opts)
      (buf-map! :n :<space>D ":lua vim.lsp.buf.type_definition()<CR>" opts)
      (buf-map! :n :<space>rn ":lua vim.lsp.buf.rename()<CR>" opts)
      (buf-map! :n :<space>ca ":lua vim.lsp.buf.code_action()<CR>" opts)
      (buf-map! :n :gr ":lua vim.lsp.buf.references()<CR>" opts)
      (buf-map! :n :<space>e ":lua vim.diagnostic.open_float()<CR>" opts)
      (buf-map! :n "[d" ":lua vim.diagnostic.goto_prev()<CR>" opts)
      (buf-map! :n "]d" ":lua vim.diagnostic.goto_next()<CR>" opts)
      (buf-map! :n :<space>q ":lua vim.diagnostic.setloclist()<CR>" opts)
      (buf-map! :n :<space>f ":lua vim.lsp.buf.formatting()<CR>" opts)))

  (local servers [:solargraph :zls])

  (each [_ lsp (ipairs servers)]
    ((. (. nvim-lsp lsp) :setup) 
     {:on_attach on-attach
      :flags {:debounce_text_changes 150}})))
