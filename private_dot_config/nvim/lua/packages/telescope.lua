local M = {}

function M.setup()
    require('telescope').setup{
        defaults = {
            initial_mode = "insert",
            layout_strategy = "center",
            layout_config = {
                height = 50
            }
        },
        extensions = {
            fzf = {
                override_generic_sorter = false, -- override the generic sorter
                override_file_sorter = true,     -- override the file sorter
                case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            }
        },
        pickers = {
            fd        = { previewer = false, sort_lastused = true },
            commands  = { theme = "ivy", sort_lastused = true },
            git_files = { previewer = false, sort_lastused = true },
            oldfiles  = { previewer = false, sort_lastused = true },
            lsp_references = { theme = "dropdown" },
            buffers = {
                previewer = false, sort_lastused = true,
                mappings = { n = { ["dd"] = require("telescope.actions").delete_buffer } }
            }
        }
    }

    function project_files()
        if not pcall(require'telescope.builtin'.git_files) then
            require'telescope.builtin'.fd()
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

    vim.cmd[[nnoremap <silent><C-S-p> :Telescope commands<cr>]]
    vim.cmd[[nnoremap <silent><Leader>f :Telescope find_files<cr>]]
    vim.cmd[[nnoremap <silent><Leader><Leader> :Telescope buffers<cr>]]
    vim.cmd[[nnoremap <silent><C-p> :lua project_files()<cr>]]
    vim.cmd[[nnoremap <silent><C-f> :Telescope live_grep<cr>]]
    vim.cmd[[nnoremap <silent><Leader>h :Telescope oldfiles<cr>]]
end

return M
