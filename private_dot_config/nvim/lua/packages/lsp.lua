local M = {}

function M.setup()
    local lsp = require 'lspconfig'
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            'documentation',
            'detail',
            'additionalTextEdits',
        }
    }

    vim.cmd [[nnoremap <silent><F2>  :lua vim.lsp.buf.rename()<CR>]]
    vim.cmd [[nnoremap <silent>gd    :lua vim.lsp.buf.declaration()<CR>]]
    vim.cmd [[noremap  <silent><c-]> :lua vim.lsp.buf.definition()<CR>]]
    vim.cmd [[nnoremap <silent>K     :lua vim.lsp.buf.hover()<CR>]]
    vim.cmd [[nnoremap <silent>gD    :lua vim.lsp.buf.implementation()<CR>]]
    vim.cmd [[noremap  <silent><c-k> :lua vim.lsp.buf.signature_help()<CR>]]
    vim.cmd [[nnoremap <silent>1gD   :lua vim.lsp.buf.type_definition()<CR>]]
    vim.cmd [[nnoremap <silent>gr    :lua vim.lsp.buf.references()<CR>]]
    vim.cmd [[nnoremap <silent>g0    :lua vim.lsp.buf.document_symbol()<CR>]]
    vim.cmd [[nnoremap <silent>gW    :lua vim.lsp.buf.workspace_symbol()<CR>]]

    local servers = {'nimls', 'zls', 'clangd', 'solargraph'}
    for _, server in ipairs(servers) do
        lsp[server].setup {
            settings = {documentFormatting = true},
            capabilities = capabilities,
            on_attach = on_attach
        }
    end

    require'nvim-treesitter.configs'.setup {
        highlight = { enable = true }
    }


    -- Map :Format to vim.lsp.buf.formatting()
    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
end

return M
