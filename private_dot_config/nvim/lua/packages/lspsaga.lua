local M = {}

function M.setup()
    require('lspsaga').init_lsp_saga()
    vim.cmd [[nnoremap <silent> gh :Lspsaga lsp_finder<CR>]]
    vim.cmd [[nnoremap <silent><leader>ca :Lspsaga code_action<CR>]]
    vim.cmd [[vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>]]
    vim.cmd [[nnoremap <silent>K :Lspsaga hover_doc<CR>]]
end

return M
