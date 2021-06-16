-- Install packer
local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
end

--setup packer
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'https://git.sr.ht/~romainl/vim-bruin'
  use 'junegunn/vim-easy-align'
  use 'tpope/vim-commentary'
  use 'tpope/vim-endwise'
  use 'junegunn/goyo.vim'
  use 'dag/vim-fish'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/vim-vsnip-integ'
  use 'hrsh7th/nvim-compe'
  use 'hrsh7th/vim-vsnip'
  use {'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}}
end)
