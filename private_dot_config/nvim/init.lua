-- VANILLA VIM CONFIGURATION
vim.g.mapleader = " "
vim.o.showmode = false
vim.o.termguicolors = true
vim.o.relativenumber = true
vim.o.hidden = true
vim.o.undofile = true
vim.o.number = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.laststatus = 0
vim.o.udir = "/tmp/nvim/undo"
vim.o.swapfile = false
vim.o.exrc = true
vim.o.wrap = false
vim.o.scrolloff = 999
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
vim.cmd [[nnoremap <silent>;d :bd<cr>]]
vim.cmd [[nnoremap <silent>;nh :noh<cr>]]
vim.cmd [[nnoremap <silent><leader>p "+p]]
vim.cmd [[vnoremap <silent><leader>y "+y]]
vim.cmd [[nnoremap <silent><leader>y "+y]]
vim.cmd [[nnoremap <silent><leader>Y gg"+yG]]
vim.cmd [[vnoremap < <gv]]
vim.cmd [[vnoremap > >gv]]
vim.cmd [[autocmd TermOpen * setlocal nonumber norelativenumber]]
vim.cmd [[tnoremap <Esc> <C-\><C-n>]]

-- Setup for github.com/mhinz/neovim-remote
-- For opening files from within :terminal without starting a nested nvim
-- process.
if vim.env.NVIM_LISTEN_ADDRESS then
    vim.env.EDITOR = "nvr --remote"
    vim.env.GIT_EDITOR = "nvr -cc split --remote-wait"
end

-- PLUGIN MANAGER INSTALLATION
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    bootstrap = os.execute("git clone --depth 1 https://github.com/wbthomason/packer.nvim " .. install_path)
end

-- Plugins
return require("packer").startup(
    function(use)
        use "wbthomason/packer.nvim" -- Packer can manage itself
        use "nvim-lua/plenary.nvim" -- Dependency of many plugins

        use "machakann/vim-sandwich"
        use "jiangmiao/auto-pairs"
        use "tpope/vim-commentary"
        use "nvim-lua/popup.nvim"
        use "pbrisbin/vim-mkdir"
        use "ap/vim-buftabline"
        use "tpope/vim-endwise"
        use "tpope/vim-eunuch"
        use "ziglang/zig.vim"

        use {"tpope/vim-dispatch", cmd = "Dispatch"}
        use {"APZelos/blamer.nvim", cmd = "BlamerToggle"}
        use {"michaelb/sniprun", run = "bash ./install.sh"}

        use {
            "https://gitlab.com/th3lusive/typography.vim",
            config = function()
                vim.cmd "colorscheme typograph"
            end
        }
        use {
            "mcchrish/nnn.vim",
            config = function()
                vim.cmd "tnoremap <C-A-n> <cmd>NnnExplorer<CR>"
                vim.cmd "nnoremap <C-A-n> <cmd>NnnExplorer %:p:h<CR>"
                vim.cmd "tnoremap <C-A-p> <cmd>NnnPicker<CR>"
                vim.cmd "nnoremap <C-A-p> <cmd>NnnPicker<CR>"
                require "nnn".setup(
                    {
                        replace_netrw = 1,
                        layout = {window = {width = 0.4, height = 0.6}}
                    }
                )
            end
        }
        use {
            "sbdchd/neoformat",
            config = function()
                vim.cmd "nnoremap <silent>;f :Neoformat<cr>"
            end
        }
        use {
            "nvim-telescope/telescope.nvim",
            config = function()
                vim.cmd "nnoremap <silent><C-p> :Telescope find_files theme=ivy<cr>"
                vim.cmd "nnoremap <silent><A-h> :Telescope oldfiles theme=dropdown<cr>"
                vim.cmd "nnoremap <silent><A-g> :Telescope live_grep theme=dropdown<cr>"
            end,
            requires = {
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "make",
                config = function()
                    require "telescope".load_extension("fzf")
                end
            }
        }
        use {
            "junegunn/vim-easy-align",
            config = function()
                vim.cmd "xnoremap <silent>ga :EasyAlign<cr>"
            end
        }
        use {
            "ms-jpq/coq_nvim",
            branch = "coq",
            requires = {"ms-jpq/coq.artifacts", branch = "artifacts"},
            run = function()
                require "coq".deps()
            end,
            config = function()
                require "coq".Now("-s")
            end
        }
        use {
            "mfussenegger/nvim-lint",
            ft = {"bash", "sh", "lua"},
            config = function()
                require "lint".linters_by_ft = {
                    sh = {"shellcheck"},
                    lua = {"luacheck"}
                }
                vim.cmd "au BufWritePost <buffer> lua require'lint'.try_lint()"
            end
        }
        use {
            "neovim/nvim-lspconfig",
            ft = {"go", "c", "cpp", "zig", "ruby", "python"},
            config = function()
                local servers = {"gopls", "zls", "pyright", "clangd", "solargraph"}
                local lsp = require "lspconfig"
                local capabilities = vim.lsp.protocol.make_client_capabilities()
                capabilities.textDocument.completion.completionItem.snippetSupport = true
                capabilities.textDocument.completion.completionItem.resolveSupport = {
                    properties = {
                        "documentation",
                        "detail",
                        "additionalTextEdits"
                    }
                }

                for _, server in ipairs(servers) do
                    lsp[server].setup {
                        on_attach = on_attach,
                        capabilities = capabilities,
                        settings = {documentFormatting = true}
                    }
                end

                vim.cmd "nnoremap <silent><F2>  :lua vim.lsp.buf.rename()<CR>"
                vim.cmd "nnoremap <silent>gd    :lua vim.lsp.buf.declaration()<CR>"
                vim.cmd "noremap  <silent><c-]> :lua vim.lsp.buf.definition()<CR>"
                vim.cmd "nnoremap <silent>K     :lua vim.lsp.buf.hover()<CR>"
                vim.cmd "nnoremap <silent>gD    :lua vim.lsp.buf.implementation()<CR>"
                vim.cmd "nnoremap <silent><c-k> :lua vim.lsp.buf.signature_help()<CR>"
                vim.cmd "nnoremap <silent>1gD   :lua vim.lsp.buf.type_definition()<CR>"
                vim.cmd "nnoremap <silent>gr    :lua vim.lsp.buf.references()<CR>"
                vim.cmd "nnoremap <silent>g0    :lua vim.lsp.buf.document_symbol()<CR>"
                vim.cmd "nnoremap <silent>gW    :lua vim.lsp.buf.workspace_symbol()<CR>"
                vim.cmd 'command! Format execute "lua vim.lsp.buf.formatting()"'
                vim.cmd "nnoremap <silent>;f :Format<cr>"
            end
        }

        -- Automatically set up configuration after cloning packer.nvim
        if bootstrap then
            require("packer").sync()
        end

        vim.cmd(
            [[
        augroup packer_user_config
        autocmd!
        autocmd BufWritePost ~/.config/nvim/init.lua source % | PackerCompile
        augroup end
    ]]
        )
    end
)
