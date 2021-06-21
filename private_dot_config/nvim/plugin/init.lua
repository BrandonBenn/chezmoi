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
  use 'tpope/vim-dispatch'
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-vinegar'
  use 'tpope/vim-endwise'
  use 'pbrisbin/vim-mkdir'
  use 'junegunn/fzf.vim'
  use 'junegunn/goyo.vim'
  use 'sbdchd/neoformat'
  use 'dag/vim-fish'
  use 'neovim/nvim-lspconfig'
  use {'Shougo/deoplete.nvim', run = ':UpdateRemotePlugins',
  requires = 'Shougo/deoplete-lsp'}
  use {'Shougo/neosnippet.vim',
  requires = 'Shougo/neosnippet-snippets'}
end)
