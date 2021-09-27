-- Install package manager
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.cmd('!git clone --depth=1 https://github.com/wbthomason/packer.nvim ' .. install_path)
end

-- Setup package manager
require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim', requires = {'nvim-lua/plenary.nvim'}}
  use 'https://gitlab.com/th3lusive/typography.vim'
  use 'editorconfig/editorconfig-vim'
  use 'junegunn/vim-easy-align'
  use 'tpope/vim-commentary'
  use 'tpope/vim-dispatch'
  use 'tpope/vim-endwise'
  use 'tpope/vim-eunuch'
  use 'pbrisbin/vim-mkdir'
  use 'jiangmiao/auto-pairs'
  use 'ap/vim-buftabline'
  use 'sbdchd/neoformat'
  use 'machakann/vim-sandwich'
  use 'APZelos/blamer.nvim'
  use 'ziglang/zig.vim'
  use { 'ms-jpq/coq_nvim', branch = 'coq' }
  use { 'ms-jpq/coq.artifacts', branch = 'artifacts'} -- 9000+ Snippets
  use {
      'mcchrish/nnn.vim',
      config = function() require('nnn').setup({}) end
  }
  use {
      'crispgm/nvim-go',
      config = function() require('go').setup({}) end
  }
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }
  use {
      'neovim/nvim-lspconfig',
      config = function() require('packages.lsp').setup() end
  }
  use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {
          'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}},
      config = function() require('packages.telescope').setup() end
  }
end)
