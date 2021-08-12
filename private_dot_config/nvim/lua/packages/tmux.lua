local M = {}

function M.setup()
    -- Configuration
    require('Navigator').setup({
        auto_save = 'current',
        disable_on_zoom = true
    })

    -- Keybindings
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    map('n', "<A-h>", "<CMD>lua require('Navigator').left()<CR>", opts)
    map('n', "<A-k>", "<CMD>lua require('Navigator').up()<CR>", opts)
    map('n', "<A-l>", "<CMD>lua require('Navigator').right()<CR>", opts)
    map('n', "<A-j>", "<CMD>lua require('Navigator').down()<CR>", opts)
    map('n', "<A-p>", "<CMD>lua require('Navigator').previous()<CR>", opts)
end

return M
