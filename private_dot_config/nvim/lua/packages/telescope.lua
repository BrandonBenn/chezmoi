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

    local notes_dir = "~/notes"

    add_note = function(title)
        slug =  string.lower(string.gsub(title, " ", "_"))
        filename = os.date("%G%m%d%H%M") .. "_" .. slug .. ".md"
        vim.cmd("edit " .. filename)
    end

    find_notes = function()
        require("telescope.builtin").find_files({
            prompt_title = "Find Notes",
            cwd = notes_dir
        })
    end

    grep_notes = function()
        require("telescope.builtin").live_grep({
            prompt_title = "Grep Notes",
            cwd = notes_dir
        })
    end

    vim.cmd([[command! FNotes execute 'lua find_notes()' ]])
    vim.cmd([[command! GNotes execute 'lua grep_notes()' ]])

    vim.cmd[[nnoremap <silent><Leader>f :Telescope find_files<cr>]]
    vim.cmd[[nnoremap <silent><Leader><Leader> :Telescope buffers<cr>]]
    vim.cmd[[nnoremap <silent><C-p> :lua project_files()<cr>]]
    vim.cmd[[nnoremap <silent><C-f> :Telescope live_grep<cr>]]
    vim.cmd[[nnoremap <silent><Leader>h :Telescope oldfiles<cr>]]
end

return M
