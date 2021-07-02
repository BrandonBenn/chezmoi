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
  use 'tpope/vim-endwise'
  use 'tpope/vim-eunuch'
  use 'pbrisbin/vim-mkdir'
  use 'mcchrish/nnn.vim'
  use 'junegunn/fzf.vim'
  use 'folke/zen-mode.nvim'
  use 'vim-autoformat/vim-autoformat'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'SirVer/ultisnips'
  use 'ThePrimeagen/vim-be-good'
  use 'ap/vim-buftabline'
  use 'jiangmiao/auto-pairs'
  use 'tversteeg/registers.nvim'
end)

require("config/lsp")
require("config/compe")
require('nnn').setup{
    set_default_mappings = false,
    session = 'global',
    layout = { window = { width = 0.4,  height = 0.4, xoffset = 0.6 } }
}
