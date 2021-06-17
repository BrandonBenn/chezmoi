-- Install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  exec('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
  print 'Run `PackerInstall` to install external packages'
end

--setup packer
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'https://git.sr.ht/~romainl/vim-bruin'
  use 'junegunn/vim-easy-align'
  use 'tpope/vim-commentary'
  use 'tpope/vim-endwise'
  use 'junegunn/fzf.vim'
  use 'junegunn/goyo.vim'
  use 'dag/vim-fish'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/vim-vsnip-integ'
  use 'hrsh7th/nvim-compe'
  use 'hrsh7th/vim-vsnip'
  use { 'jghauser/mkdir.nvim',
    config = function() require('mkdir') end }
end)
