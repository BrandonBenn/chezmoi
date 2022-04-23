local setup = function(options)
    local options = options or {}

    options.notes_dir = vim.fn.expand(options.notes_dir or vim.env.NOTES_DIR)
    local notes_dir_exists = vim.fn.isdirectory(options.notes_dir) == 1
    local telescope = require("telescope.builtin")
    assert(notes_dir_exists, "Notes directory not set")
    assert(telescope, "Telescope is required")

    options.notes_daily_dir = options.notes_daily_dir or vim.fn.expand(options.notes_dir .. "/daily")
    options.notes_ext = options.notes_ext or ".md"
    options.notes_daily_file = os.date("%Y-%m-%d") .. options.notes_ext

    vim.api.nvim_create_user_command(
        'Notes',
        function() telescope.find_files({cwd = options.notes_dir}) end,
        {desc = "Find notes"}
    )

    vim.api.nvim_create_user_command(
        'NotesDaily',
        function() vim.cmd (':edit '.. options.notes_daily_dir .. '/' .. options.notes_daily_file) end,
        {desc = "Open note of the day"}
    )

    vim.api.nvim_create_user_command(
        'NotesDailySearch',
        function() telescope.find_files({cwd = options.notes_daily_dir}) end,
        {desc = "Find daily notes"}
    )

    vim.api.nvim_create_user_command(
        'NotesGrep',
        function() telescope.live_grep({cwd = options.notes_dir}) end,
        {desc = "Search notes"}
    )
end

return {
    setup = setup
}
