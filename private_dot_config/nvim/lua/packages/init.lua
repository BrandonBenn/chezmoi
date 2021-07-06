-- Install package manager
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.cmd('!git clone --depth=1 https://github.com/wbthomason/packer.nvim ' .. install_path)
end

-- Setup package manager
require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim', requires = {'nvim-lua/plenary.nvim'}}
  use 'https://git.sr.ht/~romainl/vim-bruin'
  use 'junegunn/vim-easy-align'
  use 'tpope/vim-commentary'
  use 'tpope/vim-dispatch'
  use 'tpope/vim-surround'
  use 'tpope/vim-vinegar'
  use 'tpope/vim-endwise'
  use 'tpope/vim-eunuch'
  use 'pbrisbin/vim-mkdir'
  use 'folke/zen-mode.nvim'
  use 'vim-autoformat/vim-autoformat'
  use 'SirVer/ultisnips'
  use 'ThePrimeagen/vim-be-good'
  use 'jiangmiao/auto-pairs'
  use {
      'akinsho/nvim-bufferline.lua',
      config = require("bufferline").setup{}
  }
  use {
      'glepnir/lspsaga.nvim',
      config = require('lspsaga').init_lsp_saga()
  }
  use {
      'neovim/nvim-lspconfig',
      config = require('packages.lsp')
  }
  use {
      'hrsh7th/nvim-compe',
      config = require('packages.compe')
  }
  use {
      'nvim-telescope/telescope.nvim', requires = {'nvim-lua/popup.nvim'},
      config = require('packages.telescope')
  }
end)
