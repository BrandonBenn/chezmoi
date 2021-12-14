-- :help map-modes
function map(mode, lhs, rhs)
    vim.api.nvim_set_keymap(mode, lhs, rhs, { silent = true })
end

function noremap(mode, lhs, rhs)
    vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, silent = true })
end

function exprnoremap(mode, lhs, rhs)
    vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, silent = true, expr = true })
end

function autocmd(c)
    vim.cmd("autocmd " .. c)
end

-- stylua: ignore start
function nmap(lhs, rhs) map('n', lhs, rhs) end

function nnoremap(lhs, rhs) noremap('n', lhs, rhs) end

function vnoremap(lhs, rhs) noremap('v', lhs, rhs) end

function xnoremap(lhs, rhs) noremap('x', lhs, rhs) end

function inoremap(lhs, rhs) noremap('i', lhs, rhs) end

function tnoremap(lhs, rhs) noremap('t', lhs, rhs) end

function exprinoremap(lhs, rhs) exprnoremap('i', lhs, rhs) end

function exprnnoremap(lhs, rhs) exprnoremap('n', lhs, rhs) end

-- stylua: ignore end
