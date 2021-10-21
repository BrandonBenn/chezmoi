-- Editor
vim.g.mapleader = ' '
vim.o.showmode = false
vim.o.termguicolors = true
vim.o.relativenumber = true
vim.o.hidden = true
vim.o.undofile = true
vim.o.number = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop  = 4
vim.o.shiftwidth = 4 
vim.o.softtabstop = 4
vim.o.laststatus = 0
vim.o.udir = '/tmp/nvim/undo'
vim.o.swapfile = false
vim.o.exrc = true
vim.o.wrap = false
vim.o.completeopt = "menuone,noselect,noinsert"
vim.o.inccommand = "nosplit"
vim.cmd [[nnoremap H ^]]
vim.cmd [[nnoremap L $]]
vim.cmd [[nnoremap <silent><C-j> :cnext<cr>]]
vim.cmd [[nnoremap <silent><C-k> :cprev<cr>]]
vim.cmd [[nnoremap <silent><Tab> :bnext<cr>]]
vim.cmd [[nnoremap <silent><S-Tab> :bprev<cr>]]
vim.cmd [[nnoremap <silent>;q :quitall<cr>]]
vim.cmd [[nnoremap <silent>;w :update<cr>]]
vim.cmd [[nnoremap <silent>;bd :bd<cr>]]
vim.cmd [[nnoremap <silent>;noh :noh<cr>]]
vim.cmd [[vnoremap <silent><leader>y "+y]]
vim.cmd [[nnoremap <silent><leader>y "+y]]
vim.cmd [[vnoremap <silent><leader>p "+p]]
vim.cmd [[nnoremap <silent><leader>Y gg"+yG]]
vim.cmd [[vnoremap < <gv]]
vim.cmd [[vnoremap > >gv]]
vim.cmd [[autocmd TermOpen * setlocal nonumber norelativenumber]]
vim.cmd [[tnoremap <Esc> <C-\><C-n>]]
-- Editor


-- Paq Installation
if vim.fn.empty(vim.fn.glob(vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim')) > 0 then
  vim.fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end
-- Paq Installation



-- Plugins
require "paq" {
    "savq/paq-nvim";
    "nvim-lua/plenary.nvim";
    "neovim/nvim-lspconfig";
    {url="https://gitlab.com/th3lusive/typography.vim"};
    "ap/vim-buftabline";
    "sbdchd/neoformat";
    {"junegunn/fzf", run='./install --bin'};
    "junegunn/fzf.vim";
    "mcchrish/nnn.vim";
    "machakann/vim-sandwich";
    "junegunn/vim-easy-align";
    "tpope/vim-commentary";
    "tpope/vim-dispatch";
    "tpope/vim-endwise";
    "tpope/vim-eunuch";
    "pbrisbin/vim-mkdir";
    "jiangmiao/auto-pairs";
    "APZelos/blamer.nvim";
    {"ms-jpq/coq_nvim", branch="coq", run = function() require("coq").deps() end};
    {"ms-jpq/coq.artifacts", branch="artifacts"};
    "nvim-lua/popup.nvim";
    "numtostr/FTerm.nvim";
    "ziglang/zig.vim";
    {"ray-x/go.nvim",
    run = function() require('go').setup({
	    goimport = 'gopls', gofmt = 'gopls',
    }) end 
    };
}
-- Plugins

vim.cmd [[color typograph | set background=light]]
vim.cmd [[nnoremap <silent>;f :Neoformat<cr>]]
vim.cmd [[xnoremap <silent>ga :EasyAlign<cr>]]
vim.cmd [[nnoremap <silent><C-A-p> :NnnPicker %:p:h<cr>]]
vim.cmd [[nnoremap <silent><C-\> :lua require('FTerm').toggle()<CR>]] vim.cmd([[command! Gitui lua require("FTerm"):new({ cmd = "gitui" }):open()<CR> ]])

require("coq").Now("--shut-up")

require("nnn").setup({
    replace_netrw = 1,
    layout = { window = { width = 0.3, height = 0.4 } }
})


-- LSP Configuration
require'nvim-treesitter.configs'.setup { highlight = { enable = true } }
local lsp = require 'lspconfig'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    }
}

local servers = {'gopls', 'zls', 'pyright','clangd', 'solargraph'}
for _, server in ipairs(servers) do
    lsp[server].setup {
        settings = {documentFormatting = true},
        capabilities = capabilities,
        on_attach = on_attach
    }
end

vim.cmd [[nnoremap <silent><F2>  :lua vim.lsp.buf.rename()<CR>]]
vim.cmd [[nnoremap <silent>gd    :lua vim.lsp.buf.declaration()<CR>]]
vim.cmd [[noremap  <silent><c-]> :lua vim.lsp.buf.definition()<CR>]]
vim.cmd [[nnoremap <silent>K     :lua vim.lsp.buf.hover()<CR>]]
vim.cmd [[nnoremap <silent>gD    :lua vim.lsp.buf.implementation()<CR>]]
vim.cmd [[noremap  <silent><c-k> :lua vim.lsp.buf.signature_help()<CR>]]
vim.cmd [[nnoremap <silent>1gD   :lua vim.lsp.buf.type_definition()<CR>]]
vim.cmd [[nnoremap <silent>gr    :lua vim.lsp.buf.references()<CR>]]
vim.cmd [[nnoremap <silent>g0    :lua vim.lsp.buf.document_symbol()<CR>]]
vim.cmd [[nnoremap <silent>gW    :lua vim.lsp.buf.workspace_symbol()<CR>]]
vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
-- LSP Configuration
