local M = {}

function M.delete_under_cursor()
	local fullpath = vim.fn.expand("%:p") .. vim.fn.expand("<cfile>")
	local message = "Delete file at " .. fullpath .. "? [y/N] "
	vim.ui.input({ prompt = message }, function(answer)
		local answer = answer or "N"
		if answer ~= "y" then
			return
		end

		local rm = vim.fn.executable("trash") == 1 and "trash" or "rm -fr"
		vim.fn.system(rm .. " " .. fullpath)
		print("Deleted " .. fullpath)
		vim.cmd("redraw!")
	end)
end

return M
