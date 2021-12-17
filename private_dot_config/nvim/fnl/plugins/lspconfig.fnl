(local {: buf-map! 
        : buf-set! 
        } (require :utils))

(let [nvim-lsp (require :lspconfig)]
  (fn on-attach [client buffer]
    (buf-set! buffer :omnifunc "v:lua.vim.lsp.omnifunc")	

    (buf-map! buffer :n :gD ":lua vim.lsp.buf.declaration()<CR>")
    (buf-map! buffer :n :gd ":lua vim.lsp.buf.definition()<CR>")
    (buf-map! buffer :n :K ":lua vim.lsp.buf.hover()<CR>")
    (buf-map! buffer :n :gi ":lua vim.lsp.buf.implementation()<CR>")
    (buf-map! buffer :n :<C-k> ":lua vim.lsp.buf.signature_help()<CR>")
    (buf-map! buffer :n :<leader>wa ":lua vim.lsp.buf.add_workspace_folder()<CR>")
    (buf-map! buffer :n :<leader>wr ":lua vim.lsp.buf.remove_workspace_folder()<CR>")
    (buf-map! buffer :n :<leader>wl ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
    (buf-map! buffer :n :<leader>D ":lua vim.lsp.buf.type_definition()<CR>")
    (buf-map! buffer :n :<leader>rn ":lua vim.lsp.buf.rename()<CR>")
    (buf-map! buffer :n :<leader>ca ":lua vim.lsp.buf.code_action()<CR>")
    (buf-map! buffer :n :gr ":lua vim.lsp.buf.references()<CR>")
    (buf-map! buffer :n :<leader>e ":lua vim.diagnostic.open_float()<CR>")
    (buf-map! buffer :n "[d" ":lua vim.diagnostic.goto_prev()<CR>")
    (buf-map! buffer :n "]d" ":lua vim.diagnostic.goto_next()<CR>")
    (buf-map! buffer :n :<leader>q ":lua vim.diagnostic.setloclist()<CR>")
    (buf-map! buffer :n :<leader>f ":lua vim.lsp.buf.formatting()<CR>"))

  (local servers [:solargraph :zls])

  (each [_ lsp (ipairs servers)]
    ((. (. nvim-lsp lsp) :setup) 
     {:on_attach on-attach
      :flags {:debounce_text_changes 150}})))
