local setup = function(cfg)
    local cfg = cfg or {}

    cfg.notes_dir = vim.fn.expand(cfg.notes_dir or vim.env.NOTES_DIR)
    local notes_dir_exists = vim.fn.isdirectory(cfg.notes_dir) == 1
    local telescope = require("telescope.builtin")
    assert(notes_dir_exists, "Notes directory not set")
    assert(telescope, "Telescope is required")

    cfg.notes_daily_dir = cfg.notes_daily_dir or vim.fn.expand(cfg.notes_dir .. "/daily")
    cfg.notes_ext = cfg.notes_ext or ".md"
    cfg.notes_daily_file = os.date("%Y-%m-%d") .. cfg.notes_ext

    vim.api.nvim_create_user_command(
        'Notes',
        function() telescope.find_files({cwd = cfg.notes_dir}) end,
        {desc = "Find notes"}
    )

    vim.api.nvim_create_user_command(
        'NotesDaily',
        function() vim.cmd (':edit '.. cfg.notes_daily_dir .. '/' .. cfg.notes_daily_file) end,
        {desc = "Open note of the day"}
    )

    vim.api.nvim_create_user_command(
        'NotesDailySearch',
        function() telescope.find_files({cwd = cfg.notes_daily_dir}) end,
        {desc = "Find daily notes"}
    )

    vim.api.nvim_create_user_command(
        'NotesGrep',
        function() telescope.live_grep({cwd = cfg.notes_dir}) end,
        {desc = "Search notes"}
    )
end

return {
    setup = setup
}
