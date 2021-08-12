-- Install package manager
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
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
  use 'tpope/vim-endwise'
  use 'tpope/vim-eunuch'
  use 'pbrisbin/vim-mkdir'
  use 'folke/zen-mode.nvim'
  use 'SirVer/ultisnips'
  use 'jiangmiao/auto-pairs'
  use 'justinmk/vim-dirvish'
  use 'ap/vim-buftabline'
  use 'sbdchd/neoformat'
  use 'vim-crystal/vim-crystal'
  use 'editorconfig/editorconfig-vim'
  use 'machakann/vim-sandwich'
  use 'APZelos/blamer.nvim'
  use 'mattn/emmet-vim'
  use{
      "numToStr/Navigator.nvim",
      config = function() require('packages.tmux').setup() end
  }
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }
  use {
      'glepnir/lspsaga.nvim',
      config = function() require('packages.lspsaga').setup() end
  }
  use {
      'neovim/nvim-lspconfig',
      config = function() require('packages.lsp').setup() end
  }
  use {
      'hrsh7th/nvim-compe',
      config = function() require('packages.compe').setup() end
  }
  use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {
          'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}},
      config = function() require('packages.telescope').setup() end
  }
end)
