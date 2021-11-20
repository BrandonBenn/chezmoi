local Utils = require("utils")

exprnnoremap = Utils.exprnnoremap
nnoremap = Utils.nnoremap
vnoremap = Utils.vnoremap
xnoremap = Utils.xnoremap
inoremap = Utils.inoremap
tnoremap = Utils.tnoremap
autocmd = Utils.autocmd
set, let, cmd = vim.o, vim.g, vim.cmd

let.mapleader = " "
let.maplocalleader = ";"
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

nnoremap("H", "^")
nnoremap("L", "$")
nnoremap("<C-j>", ":cnext<cr>")
nnoremap("<C-k>", ":cprev<cr>")
nnoremap("b]", ":bnext<cr>")
nnoremap("b[", ":bprev<cr>")
nnoremap("<localleader>q", ":quitall<cr>")
nnoremap("<localleader>w", ":update<cr>")
nnoremap("<localleader>d", ":bd<cr>")
nnoremap("<localleader>nh", ":noh<cr>")
nnoremap("<leader>p", '"+p')
nnoremap("<leader>y", '"+y')
nnoremap("<leader>y", '"+y')
nnoremap("<leader>Y", 'gg"+yG')
vnoremap("<", "<gv")
vnoremap(">", ">gv")
tnoremap("<Esc>", "<C-\\><C-n>")
tnoremap("<Esc>", "<C-\\><C-n>")
tnoremap("<A-`>", "<C-\\><C-n> :ToggleTerm<CR>")
nnoremap("<A-`>", ":ToggleTerm<CR>")
autocmd("TermOpen * setlocal nonumber norelativenumber")

-- Setup for github.com/mhinz/neovim-remote For opening files from within
-- :terminal without starting a nested nvim process.
if vim.env.NVIM_LISTEN_ADDRESS then
    vim.env.EDITOR = "nvr --remote"
    vim.env.GIT_EDITOR = "nvr -cc split --remote-wait"
end

if vim.fn.exists("g:gnvim") == 1 then
    vim.cmd [[set guifont=JetBrains\ Mono:h12]]
    set.background = "light"
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
            "michaelb/sniprun",
            run = "bash ./install.sh",
            config = function()
                nnoremap("<localleader>ee", ":SnipRun<CR>")
                nnoremap("<localleader>ew", ":SnipClose<CR>")
                xnoremap("<localleader>ee", ":SnipRun<CR>")
            end
        }
        use {
            "https://gitlab.com/th3lusive/typography.vim",
            config = function()
                vim.cmd "colorscheme typograph"
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
                telescope = require "telescope.builtin"
                local action_layout = require("telescope.actions.layout")
                require("telescope").setup {
                    defaults = {
                        mappings = {
                            n = {
                                ["<M-p>"] = action_layout.toggle_preview
                            },
                            i = {
                                ["<M-p>"] = action_layout.toggle_preview
                            }
                        }
                    },
                    pickers = {
                        find_files = {
                            theme = "ivy",
                            previewer = false
                        },
                        git_files = {
                            theme = "ivy",
                            previewer = false
                        },
                        oldfiles = {
                            theme = "ivy",
                            previewer = false
                        },
                        live_grep = {
                            theme = "dropdown",
                            height = 0.8,
                            width = 0.8
                        }
                    }
                }

                live_greps = telescope.live_greps
                oldfiles = telescope.oldfiles
                project_files = function()
                    local ok = pcall(telescope.git_files)
                    if not ok then
                        telescope.find_files()
                    end
                end

                nnoremap("<C-p>", ":lua project_files()<cr>")
                nnoremap("<A-h>", ":lua oldfiles()<cr>")
                nnoremap("<A-g>", ":lua live_grep()<cr>")
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
                xnoremap("ga", ":EasyAlign<cr>")
            end
        }

        use {
            "ms-jpq/chadtree",
            branch = "chad",
            run = "python3 -m chadtree deps",
            config = function()
                let.chadtree_settings = {
                    view = {
                        open_direction = "right"
                    },
                    theme = {
                        icon_glyph_set = "ascii"
                    }
                }
                nnoremap("<leader>v", ":CHADopen<cr>")
            end
        }

        use {
            "ms-jpq/coq_nvim",
            branch = "coq",
            requires = {"ms-jpq/coq.artifacts", branch = "artifacts"},
            run = "python3 -m coq deps",
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
                autocmd [[BufWritePost <buffer> lua require'lint'.try_lint()]]
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

                nnoremap("<F2>", [[:lua vim.lsp.buf.rename()<CR>]])
                nnoremap("gd", [[:lua vim.lsp.buf.declaration()<CR>]])
                nnoremap("<c-]>", [[:lua vim.lsp.buf.definition()<CR>]])
                nnoremap("K", [[:lua vim.lsp.buf.hover()<CR>]])
                nnoremap("gD", [[:lua vim.lsp.buf.implementation()<CR>]])
                nnoremap("<c-k>", [[:lua vim.lsp.buf.signature_help()<CR>]])
                nnoremap("1gD", [[:lua vim.lsp.buf.type_definition()<CR>]])
                nnoremap("gr", [[:lua vim.lsp.buf.references()<CR>]])
                nnoremap("g0", [[:lua vim.lsp.buf.document_symbol()<CR>]])
                nnoremap("gW", [[:lua vim.lsp.buf.workspace_symbol()<CR>]])

                cmd [[command! Format execute "lua vim.lsp.buf.formatting()"]]
                nnoremap(";f", ":Format<cr>")
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
