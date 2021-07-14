local M = {}

function M.setup()
    require('telescope').setup{
        pickers = {
            find_files = { theme = "dropdown", previewer = false, sort_lastused = true, },
            git_files  = { theme = "dropdown", previewer = false, sort_lastused = true, },
            oldfiles   = { theme = "dropdown", previewer = false, sort_lastused = true, },
            live_grep  = { theme = "dropdown" },
            lsp_references = { theme = "dropdown" },
            buffers = {
                theme = "dropdown", previewer = false, sort_lastused = true,
                mappings = { n = { ["dd"] = require("telescope.actions").delete_buffer } }
            }
        }
    }

    function project_files()
        if not pcall(require'telescope.builtin'.git_files) then
            require'telescope.builtin'.find_files()
        end
    end

    vim.cmd[[nnoremap <silent><Leader>f :Telescope find_files<cr>]]
    vim.cmd[[nnoremap <silent><Leader>b :Telescope buffers<cr>]]
    vim.cmd[[nnoremap <silent><C-p> :lua project_files()<cr>]]
    vim.cmd[[nnoremap <silent><C-f> :Telescope live_grep<cr>]]
    vim.cmd[[nnoremap <silent><Leader>h :Telescope oldfiles<cr>]]
end

return M
