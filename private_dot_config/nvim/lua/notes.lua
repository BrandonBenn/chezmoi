local M = {}

local keymap = vim.keymap.set
local command = vim.api.nvim_create_user_command

local function sanitize(title)
  local tolower = vim.fn.tolower
  return tolower(title) -- downcase words
      :gsub("%p+", "")  -- remove punctuation
      :gsub("%s+", "-") -- change spaces to dashes
end

function fallback_find_files(notes_dir)
  local telescope = require("telescope.builtin")
  if telescope then
    telescope.find_files({ cwd = notes_dir })
  else
    local files = vim.fs.find({ notes_dir }, { type = "file" })
    vim.ui.select(
      files, { prompt = 'Files: ' },
      function(choice)
        vim.cmd.edit(vim.fs.normalize(choice))
      end)
  end
end

function M.setup(cfg)
  local cfg = cfg or {}

  assert(cfg.notes_dir, "Notes directory not set")

  cfg.notes_dir = vim.fs.normalize(cfg.notes_dir)

  cfg.notes_daily_dir = cfg.notes_daily_dir or vim.fn.expand(cfg.notes_dir .. "/daily")
  cfg.notes_ext = cfg.notes_ext or ".md"
  cfg.daily_filename_format = cfg.daily_filename_format or "%Y-%m-%d"
  cfg.identifier_format = cfg.identifier_format or "%Y%m%dT%H%M%S"
  cfg.notes_daily_file = os.date(cfg.daily_filename_format) .. cfg.notes_ext

  command("Notes", function(opts)
    vim.ui.input({ prompt = "New Note? [y/N] " }, function(answer)
      local answer = answer or "N"
      if answer == "y" or answer == "Y" then
        vim.ui.input({ prompt = "Title: " }, function(input)
          local input = input or ""
          if #input > 0 then
            local filename = sanitize(input)
            filename = cfg.notes_dir .. "/" .. filename .. cfg.notes_ext
            local identifier = os.date(cfg.identifier_format)
            vim.cmd(":edit " .. filename)
            vim.api.nvim_buf_set_lines(0, 0, 0, false, { "---" })
            vim.api.nvim_buf_set_lines(0, 1, 1, false, { "title: " .. input })
            vim.api.nvim_buf_set_lines(0, 2, 2, false, { "identifier: " .. identifier })
            vim.api.nvim_buf_set_lines(0, 3, 3, false, { "---" })
          end
        end)
      else
        fallback_find_files(cfg.notes_dir)
      end
    end)
  end, { desc = "Find/Create notes" })

  command("NotesDaily", function(opts)
    if #opts.fargs > 0 then
      local filename = sanitize(opts.args)
      filename = cfg.notes_daily_dir .. "/" .. os.date(cfg.daily_filename_format) .. "-" .. filename .. cfg.notes_ext
      vim.cmd(":edit " .. filename)
    else
      local filename = cfg.notes_daily_dir .. "/" .. cfg.notes_daily_file
      vim.cmd(":edit " .. filename)
    end
  end, { desc = "Open note of the day" })

  command("NotesDailyFind", function(opts)
    fallback_find_files(cfg.notes_dir)
  end, { desc = "Find daily notes" })

  command("NotesGrep", function()
    local telescope = require("telescope.builtin")
    telescope.live_grep({ cwd = cfg.notes_dir })
  end, { desc = "Search notes" })
end

return M
