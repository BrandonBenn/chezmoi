local M = {}

function M.setup()
    require('lspsaga').init_lsp_saga()
    vim.cmd [[nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>]]
    vim.cmd [[nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>]]
    vim.cmd [[vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>]]
end

return M
