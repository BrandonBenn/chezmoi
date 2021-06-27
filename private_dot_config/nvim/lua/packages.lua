-- Install package manager
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

-- Setup package manager
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'https://git.sr.ht/~romainl/vim-bruin'
  use 'junegunn/vim-easy-align'
  use 'tpope/vim-commentary'
  use 'tpope/vim-dispatch'
  use 'tpope/vim-surround'
  use 'tpope/vim-vinegar'
  use 'tpope/vim-endwise'
  use 'pbrisbin/vim-mkdir'
  use 'junegunn/fzf.vim'
  use 'folke/zen-mode.nvim'
  use 'TimUntersberger/neogit'
  use 'vim-autoformat/vim-autoformat'
  use 'dag/vim-fish'
  use 'neovim/nvim-lspconfig'
  use {'Shougo/deoplete.nvim', run = ':UpdateRemotePlugins', requires = 'Shougo/deoplete-lsp'}
  use {'Shougo/neosnippet.vim',
  requires = 'Shougo/neosnippet-snippets'}
  use 'ThePrimeagen/vim-be-good'
  use 'akinsho/nvim-bufferline.lua'
end)

require("bufferline").setup{}
require("lsp")
