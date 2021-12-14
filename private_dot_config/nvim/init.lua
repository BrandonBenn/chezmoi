require("utils")
require("basics")
local load_plugins = require("plugins/packer").plugins

-- PLUGIN MANAGER INSTALLATION
-- Automatically set up configuration after cloning packer.nvim
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.isdirectory(install_path) == 1 then
	load_plugins()
	vim.cmd([[
	       augroup packer_user_config
	       autocmd!
	       autocmd BufWritePost ~/.config/nvim/init.lua source % | PackerCompile
	       augroup end
	   ]])
else
	vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packloadall]])
	load_plugins()
	require("packer").sync()
end
