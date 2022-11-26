function load_config()
	for _, module in pairs(vim.split(vim.fn.glob("~/.config/nvim/modules/*.lua"), "\n")) do
		dofile(module)
	end
end

vim.api.nvim_create_user_command("ReloadConfig", load_config, { desc = "Reload Neovim Configuration" })

vim.cmd([[packadd packer.nvim]])
load_config()
