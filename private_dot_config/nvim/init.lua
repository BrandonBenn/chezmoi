function load_config()
	for _, module in pairs(vim.split(vim.fn.glob("~/.config/nvim/modules/*.lua"), "\n")) do
		if module:find("00-", 1, true) ~= nil then
			dofile(module)
		else
			vim.defer_fn(function()
				dofile(module)
			end, 1000)
		end
	end
end

vim.api.nvim_create_user_command("ReloadConfig", load_config, { desc = "Reload Neovim Configuration" })

vim.cmd([[packadd packer.nvim]])
load_config()
