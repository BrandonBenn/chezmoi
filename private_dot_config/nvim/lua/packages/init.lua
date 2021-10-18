-- Install package manager
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.cmd('!git clone --depth=1 https://github.com/wbthomason/packer.nvim ' .. install_path)
end

-- Setup package manager
require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim', requires = {'nvim-lua/plenary.nvim'}} -- Language Support
  use 'ziglang/zig.vim'
  use { 
      'ray-x/go.nvim',
      config = function() require('go').setup({
        goimport = 'gopls', gofmt = 'gopls',
      }) end 
  }

  -- Editing
  use 'sbdchd/neoformat'
  use 'machakann/vim-sandwich'
  use 'editorconfig/editorconfig-vim'
  use 'junegunn/vim-easy-align'
  use 'tpope/vim-commentary'
  use 'tpope/vim-dispatch'
  use 'tpope/vim-endwise'
  use 'tpope/vim-eunuch'
  use 'pbrisbin/vim-mkdir'
  use 'jiangmiao/auto-pairs'
  use { 'ms-jpq/coq_nvim', branch = 'coq' }
  use { 'ms-jpq/coq.artifacts', branch = 'artifacts'} -- 9000+ Snippets

  -- UI 
  use 'https://gitlab.com/th3lusive/typography.vim'
  use 'APZelos/blamer.nvim'
  use {
      'luukvbaal/nnn.nvim',
      config = function()
          require("nnn").setup({
              picker = { style = { width = 0.5, height = 0.5, xoffset = 0.8 } },
              replace_netrw = "picker"
          })
      end
  }
  use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {
          'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}},
      config = function() require('packages.telescope').setup() end
  }

  -- LSP
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }
  use {
      'neovim/nvim-lspconfig',
      config = function() require('packages.lsp').setup() end
  }
end)
