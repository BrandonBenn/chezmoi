-- VANILLA VIM CONFIGURATION
set, let, cmd = vim.o, vim.g, vim.cmd
let.mapleader = " "
set.showmode = false
set.termguicolors = true
set.relativenumber = true
set.hidden = true
set.undofile = true
set.number = true
set.expandtab = true
set.smartindent = true
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.laststatus = 0
set.udir = "/tmp/nvim/undo"
set.swapfile = false
set.exrc = true
set.wrap = false
set.scrolloff = 999
set.completeopt = "menuone,noselect,noinsert"
set.inccommand = "nosplit"

cmd [[nnoremap H ^]]
cmd [[nnoremap L $]]
cmd [[nnoremap <silent><C-j> :cnext<cr>]]
cmd [[nnoremap <silent><C-k> :cprev<cr>]]
cmd [[nnoremap <silent><Tab> :bnext<cr>]]
cmd [[nnoremap <silent><S-Tab> :bprev<cr>]]
cmd [[nnoremap <silent>;q :quitall<cr>]]
cmd [[nnoremap <silent>;w :update<cr>]]
cmd [[nnoremap <silent>;d :bd<cr>]]
cmd [[nnoremap <silent>;nh :noh<cr>]]
cmd [[nnoremap <silent><leader>p "+p]]
cmd [[vnoremap <silent><leader>y "+y]]
cmd [[nnoremap <silent><leader>y "+y]]
cmd [[nnoremap <silent><leader>Y gg"+yG]]
cmd [[vnoremap < <gv]]
cmd [[vnoremap > >gv]]
cmd [[tnoremap <Esc> <C-\><C-n>]]
cmd [[autocmd TermOpen * setlocal nonumber norelativenumber]]

-- Setup for github.com/mhinz/neovim-remote For opening files from within
-- :terminal without starting a nested nvim process.
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

        use "ap/vim-buftabline"
        use "jiangmiao/auto-pairs"
        use "machakann/vim-sandwich"
        use "nvim-lua/popup.nvim"
        use "pbrisbin/vim-mkdir"
        use "tpope/vim-commentary"
        use "tpope/vim-endwise"
        use "tpope/vim-eunuch"
        use "ziglang/zig.vim"

        use {"tpope/vim-dispatch", cmd = "Dispatch"}

        use {"APZelos/blamer.nvim", cmd = "BlamerToggle"}

        use {
            "TimUntersberger/neogit",
            config = function()
                require("neogit").setup()
                cmd [[nnoremap <silent>;gg  <cmd>:Neogit<CR>]]
            end
        }

        use {
            "ygm2/rooter.nvim",
            config = function()
                let.rooter_pattern = {
                    ".git",
                    ".luacheckrc",
                    "Gemfile",
                    "Makefile",
                    "node_modules",
                    "CMakeLists.txt"
                }
                let.outermost_root = true
            end
        }
        use {
            "michaelb/sniprun",
            run = "bash ./install.sh",
            config = function()
                cmd [[nnoremap <silent>;ee  <cmd>:SnipRun<CR>]]
                cmd [[nnoremap <silent>;ew  <cmd>:SnipClose<CR>]]
                cmd [[xnoremap <silent>;ee  <cmd>:SnipRun<CR>]]
            end
        }

        use {
            "https://gitlab.com/th3lusive/typography.vim",
            config = function()
                vim.cmd "colorscheme typograph"
            end
        }
        use {
            "mcchrish/nnn.vim",
            config = function()
                cmd "tnoremap <C-A-n> <cmd>NnnExplorer %:p:h<CR>"
                cmd "nnoremap <C-A-n> <cmd>NnnExplorer %:p:h<CR>"
                cmd "tnoremap <C-A-p> <cmd>NnnPicker<CR>"
                cmd "nnoremap <C-A-p> <cmd>NnnPicker<CR>"
                require "nnn".setup(
                    {
                        command = "nnn -C",
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
                cmd "nnoremap <silent><C-p> :Telescope find_files theme=ivy<cr>"
                cmd "nnoremap <silent><A-h> :Telescope oldfiles theme=dropdown<cr>"
                cmd "nnoremap <silent><A-g> :Telescope live_grep theme=dropdown<cr>"
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
                cmd [[au BufWritePost <buffer> lua require'lint'.try_lint()]]
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

                cmd [[nnoremap <silent><F2>  :lua vim.lsp.buf.rename()<CR>]]
                cmd [[nnoremap <silent>gd    :lua vim.lsp.buf.declaration()<CR>]]
                cmd [[noremap  <silent><c-]> :lua vim.lsp.buf.definition()<CR>]]
                cmd [[nnoremap <silent>K     :lua vim.lsp.buf.hover()<CR>]]
                cmd [[nnoremap <silent>gD    :lua vim.lsp.buf.implementation()<CR>]]
                cmd [[nnoremap <silent><c-k> :lua vim.lsp.buf.signature_help()<CR>]]
                cmd [[nnoremap <silent>1gD   :lua vim.lsp.buf.type_definition()<CR>]]
                cmd [[nnoremap <silent>gr    :lua vim.lsp.buf.references()<CR>]]
                cmd [[nnoremap <silent>g0    :lua vim.lsp.buf.document_symbol()<CR>]]
                cmd [[nnoremap <silent>gW    :lua vim.lsp.buf.workspace_symbol()<CR>]]
                cmd [[command! Format execute "lua vim.lsp.buf.formatting()"]]
                cmd [[nnoremap <silent>;f :Format<cr>]]
            end
        }

        -- Automatically set up configuration after cloning packer.nvim
        if bootstrap then
            require("packer").sync()
        end

        cmd(
            [[
        augroup packer_user_config
        autocmd!
        autocmd BufWritePost ~/.config/nvim/init.lua source % | PackerCompile
        augroup end
    ]]
        )
    end
)
