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
  use 'https://github.com/cideM/yui'
  use 'junegunn/vim-easy-align'
  use 'tpope/vim-commentary'
  use 'junegunn/goyo.vim'
  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'},
    {'nvim-lua/plenary.nvim'}}}
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'jiangmiao/auto-pairs'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'rafamadriz/friendly-snippets'
end)
