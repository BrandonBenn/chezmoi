local servers = { "solargraph" }

local status, nvim_lsp = pcall(require, 'lspconfig')
if not status then
    print('lspconfig not initialized')
    return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  map('n', '[d',         ':lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  map('n', ']d',         ':lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  map('n', 'gD',         ':lua vim.lsp.buf.declaration()<CR>', opts)
  map('n', 'gd',         ':lua vim.lsp.buf.definition()<CR>', opts)
  map('n', 'gi',         ':lua vim.lsp.buf.implementation()<CR>', opts)
  map('n', 'gr',         ':lua vim.lsp.buf.references()<CR>', opts)
  map('n', 'K',          ':lua vim.lsp.buf.hover()<CR>', opts)
  map('n', '<Leader>=',  ':lua vim.lsp.buf.formatting()<CR>', opts)
  map('n', '<Leader>ld', ':lua vim.lsp.buf.type_definition()<CR>', opts)
  map('n', '<Leader>lr', ':lua vim.lsp.buf.rename()<CR>', opts)
  map('n', '<Leader>la', ':lua vim.lsp.buf.code_action()<CR>', opts)
  map('n', '<Leader>le', ':lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  map('n', '<Leader>ld', ':lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  map('n', '<leader>f',  ':GitFiles<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach
  }
end
