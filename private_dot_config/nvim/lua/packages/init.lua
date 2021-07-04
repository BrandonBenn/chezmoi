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
  use { 'junegunn/fzf.vim', requires = {'junegunn/fzf', run = './install --all'} }
  use 'folke/zen-mode.nvim'
  use 'vim-autoformat/vim-autoformat'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'SirVer/ultisnips'
  use 'ThePrimeagen/vim-be-good'
  use 'akinsho/nvim-bufferline.lua'
  use 'glepnir/lspsaga.nvim'
  use 'jiangmiao/auto-pairs'
  use 'tversteeg/registers.nvim'
end)

require("packages/lsp")
require("packages/compe")

require("bufferline").setup{}
require('lspsaga').init_lsp_saga()
