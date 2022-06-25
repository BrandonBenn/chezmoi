local export = {}

local keymap = vim.keymap.set
local command = vim.api.nvim_create_user_command

function sanitize(title)
	local tolower = vim.fn.tolower
	return tolower(title) -- downcase words
		:gsub("%p+", "") -- remove punctuation
		:gsub("%s+", "-") -- change spaces to dashes
end

function export.setup(cfg)
	local cfg = cfg or {}

	local telescope = require("telescope.builtin")
	assert(cfg.notes_dir, "Notes directory not set")
	assert(telescope, "Telescope is required")

	cfg.notes_daily_dir = cfg.notes_daily_dir or vim.fn.expand(cfg.notes_dir .. "/daily")
	cfg.notes_ext = cfg.notes_ext or ".md"
	cfg.notes_daily_file = os.date("%Y%m%dT%H%M%S") .. cfg.notes_ext

	command("Notes", function(opts)
		vim.ui.input({ prompt = "New Note? [y/N] " }, function(answer)
			local answer = answer or "N"
			if answer == "y" or answer == "Y" then
				vim.ui.input({ prompt = "Title: " }, function(input)
					local input = input or ""
					if #input > 0 then
						local filename = sanitize(input)
						filename = cfg.notes_dir .. "/" .. filename .. cfg.notes_ext
						local identifier = os.date("%Y%m%dT%H%M%S")
						vim.cmd(":edit " .. filename)
						vim.api.nvim_buf_set_lines(0, 0, 0, false, { "---" })
						vim.api.nvim_buf_set_lines(0, 1, 1, false, { "title: " .. input })
						vim.api.nvim_buf_set_lines(0, 2, 2, false, { "identifier: " .. identifier })
						vim.api.nvim_buf_set_lines(0, 3, 3, false, { "---" })
					end
				end)
			else
				telescope.find_files({ cwd = cfg.notes_dir })
			end
		end)
	end, { desc = "Find/Create notes" })

	command("NotesDaily", function(opts)
		if #opts.fargs > 0 then
			local filename = sanitize(opts.args)
			filename = cfg.notes_daily_dir .. "/" .. os.date("%Y-%m-%d") .. "-" .. filename .. cfg.notes_ext
			vim.cmd(":edit " .. filename)
		else
			local filename = cfg.notes_daily_dir .. "/" .. cfg.notes_daily_file
			vim.cmd(":edit " .. filename)
		end
	end, { desc = "Open note of the day" })

	command("NotesDailyFind", function(opts)
		telescope.find_files({ cwd = cfg.notes_daily_dir })
	end, { desc = "Find daily notes" })

	command("NotesGrep", function()
		telescope.live_grep({ cwd = cfg.notes_dir })
	end, { desc = "Search notes" })
end

return export
