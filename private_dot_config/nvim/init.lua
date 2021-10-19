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
vim.cmd [[vnoremap <silent><C-c> "+y]]
vim.cmd [[noremap <silent><C-c> "+y]]
vim.cmd [[noremap <silent><c-v> "+p]]
vim.cmd [[nnoremap <silent><leader>Y gg"+yG]]
vim.cmd [[vnoremap < <gv]]
vim.cmd [[vnoremap > >gv]]
vim.cmd [[autocmd TermOpen * setlocal nonumber norelativenumber]]
vim.cmd [[tnoremap <Esc> <C-\><C-n>]]
vim.cmd [[tnoremap <A-h> <C-\><C-N><C-w>h]]
vim.cmd [[tnoremap <A-j> <C-\><C-N><C-w>j]]
vim.cmd [[tnoremap <A-k> <C-\><C-N><C-w>k]]
vim.cmd [[tnoremap <A-l> <C-\><C-N><C-w>l]]
vim.cmd [[inoremap <A-h> <C-\><C-N><C-w>h]]
vim.cmd [[inoremap <A-j> <C-\><C-N><C-w>j]]
vim.cmd [[inoremap <A-k> <C-\><C-N><C-w>k]]
vim.cmd [[inoremap <A-l> <C-\><C-N><C-w>l]]
vim.cmd [[nnoremap <A-h> <C-w>h]]
vim.cmd [[nnoremap <A-j> <C-w>j]]
vim.cmd [[nnoremap <A-k> <C-w>k]]
vim.cmd [[nnoremap <A-l> <C-w>l]]

toggle_mouse = function()
    if vim.o.mouse == "a" then
        vim.o.mouse = ""
        print "Toggle Mouse Off"
    else
        vim.o.mouse = "a"
        print "Toggle Mouse On"
    end
end
vim.cmd [[command! ToggleMouse execute 'lua toggle_mouse()']]

if vim.fn.empty(vim.fn.glob(vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim')) > 0 then
  vim.fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

-- Plugins
require "paq" {
    "savq/paq-nvim";
    "nvim-lua/plenary.nvim";
    "neovim/nvim-lspconfig";
    {url="https://gitlab.com/th3lusive/typography.vim"};
    "ap/vim-buftabline";
    "sbdchd/neoformat";
    "machakann/vim-sandwich";
    "editorconfig/editorconfig-vim";
    "junegunn/vim-easy-align";
    "tpope/vim-commentary";
    "tpope/vim-dispatch";
    "tpope/vim-endwise";
    "tpope/vim-eunuch";
    "pbrisbin/vim-mkdir";
    "jiangmiao/auto-pairs";
    "APZelos/blamer.nvim";
    { "ms-jpq/coq_nvim", branch="coq" };
    { "ms-jpq/coq.artifacts", branch="artifacts"};
    "luukvbaal/nnn.nvim";
    "nvim-lua/popup.nvim";
    "nvim-telescope/telescope.nvim";
    "voldikss/vim-floaterm";
    "ziglang/zig.vim";
    { 
        "ray-x/go.nvim",
        config = function() require('go').setup({
            goimport = 'gopls', gofmt = 'gopls',
        }) end 
    };
}

vim.cmd [[color typograph | set background=light]]
vim.cmd [[nnoremap <silent>;f :Neoformat<cr>]]
vim.cmd [[xnoremap <silent>ga :EasyAlign<cr>]]
vim.cmd [[nnoremap <silent><C-A-n> :NnnExplorer %:p:h<cr>]]
vim.cmd [[nnoremap <silent><C-A-p> :NnnPicker %:p:h<cr>]]
vim.cmd([[ command! Gitui FloatermNew gitui ]])


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
local servers = {'gopls', 'zls', 'pyright','clangd', 'solargraph'}
for _, server in ipairs(servers) do
    lsp[server].setup {
        settings = {documentFormatting = true},
        capabilities = capabilities,
        on_attach = on_attach
    }
end

vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

require('telescope').setup{
    defaults = {
        initial_mode = "insert",
        layout_strategy = "center",
        layout_config = {
            height = 50
        }
    },
    extensions = {
        fzf = {
            override_generic_sorter = false, -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        }
    },
    pickers = {
        fd        = { previewer = false, sort_lastused = true },
        commands  = { theme = "ivy", sort_lastused = true },
        git_files = { previewer = false, sort_lastused = true },
        oldfiles  = { previewer = false, sort_lastused = true },
        lsp_references = { theme = "dropdown" },
        buffers = {
            previewer = false, sort_lastused = true,
            mappings = { n = { ["dd"] = require("telescope.actions").delete_buffer } }
        }
    }
}

function project_files()
    if not pcall(require'telescope.builtin'.git_files) then
        require'telescope.builtin'.fd()
    end
end

vim.cmd[[nnoremap <silent><C-p> :lua project_files()<cr>]]
vim.cmd[[nnoremap <silent><C-f> :Telescope live_grep<cr>]]
vim.cmd[[nnoremap <silent><c-h> :Telescope oldfiles<cr>]]
