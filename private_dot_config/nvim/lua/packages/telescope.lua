require('telescope').setup{
    pickers = {
        telescope = { theme = "ivy", previewer = false },
        find_files = { theme = "ivy", previewer = false },
        git_files = { theme = "ivy", previewer = false },
        oldfiles = { theme = "ivy", previewer = false },
        lsp_references = { theme = "dropdown" },
        buffers = {
            sort_lastused = true, theme = "ivy", previewer = false,
            mappings = { n = { ["<c-d>"] = require("telescope.actions").delete_buffer } }
        }
    }
}

project_files = function()
  local ok   = pcall(require'telescope.builtin'.git_files)
  if not ok then require'telescope.builtin'.find_files() end
end

vim.cmd[[nnoremap <silent><Leader>f :Telescope find_files<cr>]]
vim.cmd[[nnoremap <silent><C-p> :lua project_files()<cr>]]
vim.cmd[[nnoremap <silent><Leader>h :Telescope oldfiles<cr>]]
vim.cmd[[nnoremap <silent><leader>lr :Telescope lsp_references<CR>]]
