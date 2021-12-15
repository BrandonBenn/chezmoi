require("utils")

local M = {}
function M.plugins()
	require("packer").startup(function(use)
		use({
			"wbthomason/packer.nvim", -- Packer can manage itself
			-- Dependency of many plugins
			requires = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
		})

		use("pbrisbin/vim-mkdir")
		use("tpope/vim-endwise")
		use("tpope/vim-eunuch")
		use("ziglang/zig.vim")

		use({ "github/copilot.vim", cmd = "Copilot" })

		use({ "APZelos/blamer.nvim", cmd = "BlamerToggle" })

		use({
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup({})
			end,
		})

        use({"jamestthompson3/nvim-remote-containers"})

		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

		use({
			"https://gitlab.com/th3lusive/typography.vim",
			config = function()
				-- I don't usually use a gui, but when I do, set the
				-- background.
				if vim.g.neovide then
					return
				end
				vim.o.background = "light"
				vim.cmd([[colorscheme typograph]])
			end,
		})

		use({
			"norcalli/nvim-colorizer.lua",
			cmd = { "ColorizerToggle" },
			ft = { "css", "config" },
			config = function()
				require("colorizer").setup()
			end,
		})

		use({
			"akinsho/bufferline.nvim",
			config = function()
				require("bufferline").setup({})
				nnoremap([[<TAB>]], [[:bnext<CR>]])
				nnoremap([[<S-TAB>]], [[:bprev<CR>]])
			end,
		})

		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		})

		use({
			"blackCauldron7/surround.nvim", -- Easily switch different types of enclosed braces.
			config = function()
				require("surround").setup({ mappings_style = "sandwich" })
			end,
		})

		use({
			"ygm2/rooter.nvim", -- Change root directory to project file root
			-- When inside a project, set the project to be the root directory
			-- so the linters, formatters, file finder is project specific.
			config = function()
				vim.g.rooter_pattern = {
					".git",
					"Makefile",
					"selene.toml",
					"CMakeLists.txt",
				}
				vim.g.outermost_root = true
			end,
		})

		use({
			"sbdchd/neoformat",
			config = function()
				nnoremap("<leader>=", ":Neoformat<cr>")
			end,
		})

		use({
			"mcchrish/nnn.vim",
			config = function()
				require("nnn").setup({
					command = "nnn -o",
					set_default_mappings = 0,
					replace_netrw = 1,
					explorer_layout = { right = "~20%" },
					layout = {
						window = {
							width = 0.2,
							height = 0.6,
							xoffset = 0.8,
						},
					},
					action = {
						["<c-t>"] = "tab split",
						["<c-s>"] = "split",
						["<c-v>"] = "vsplit",
					},
				})
				nnoremap([[<leader>ff]], [[:NnnPicker %:p:h<CR>]])
				nnoremap([[<leader>fe]], [[:NnnExplorer %:p:h<CR>]])
			end,
		})

		use({
			"folke/zen-mode.nvim",
			config = function()
				require("zen-mode").setup({
					window = {
						options = {
							number = true,
							relativenumber = true,
						},
					},
				})
				nnoremap("<leader>z", ":ZenMode<cr>")
			end,
		})

		use({
			"nvim-telescope/telescope.nvim",
			config = function()
				local telescope = require("telescope.builtin")
				local action_layout = require("telescope.actions.layout")
				local default_picker = { theme = "ivy", previewer = false }

				require("telescope").setup({
					defaults = {
						mappings = {
							n = {
								["<M-p>"] = action_layout.toggle_preview,
							},
							i = {
								["<M-p>"] = action_layout.toggle_preview,
							},
						},
					},
					pickers = {
						live_grep = default_picker,
						find_files = default_picker,
						git_files = default_picker,
						oldfiles = default_picker,
						buffers = {
							theme = "dropdown",
							previewer = false,
						},
					},
				})

				function _G.project_files()
					local ok = pcall(telescope.git_files)
					if not ok then
						telescope.find_files()
					end
				end

				vim.cmd([[command! ProjectFiles execute "call v:lua.project_files()"]])
				nnoremap("<C-p>", ":ProjectFiles<cr>")
				nnoremap("<A-h>", ":Telescope oldfiles<cr>")
				nnoremap("<A-g>", ":Telescope live_grep<cr>")
				nnoremap("<A-b>", ":Telescope buffers<cr>")
			end,
			requires = {
				{
					"jvgrootveld/telescope-zoxide",
					config = function()
						require("telescope").load_extension("zoxide")
						nnoremap("<leader>cd", ":Telescope zoxide list theme=dropdown<CR>")
					end,
				},
				use({
					"nvim-telescope/telescope-frecency.nvim",
					requires = { "tami5/sqlite.lua" },
					config = function()
						require("telescope").load_extension("frecency")
						nnoremap("<A-h>", ":Telescope frecency theme=ivy<cr>")
					end,
				}),
			},
		})

		use({
			"junegunn/vim-easy-align",
			config = function()
				xnoremap("ga", ":EasyAlign<cr>")
			end,
		})

		use({
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			requires = {
				{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
				{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
				{ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
				{ "hrsh7th/cmp-path", after = "nvim-cmp" },
				{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp", requires = "L3MON4D3/LuaSnip" },
			},
			config = function()
				local cmp = require("cmp")
				cmp.setup({
					completion = { completeopt = "menu,menuone,noinsert" },
					mapping = {
						["<C-b>"] = cmp.mapping.scroll_docs(-4),
						["<C-f>"] = cmp.mapping.scroll_docs(4),
						["<A-Space>"] = cmp.mapping.complete(),
						["<C-e>"] = cmp.mapping.close(),
						["<C-y>"] = cmp.mapping.confirm({
							select = true,
							behaviour = cmp.ConfirmBehavior.Insert,
						}),
					},
					sources = {
						{ name = "nvim_lua" },
						{ name = "nvim_lsp" },
						{ name = "path" },
						{ name = "luasnip" },
						{ name = "buffer", keyword_lenght = 4 },
					},
					snippet = {
						expand = function(args)
							require("luasnip").lsp_expand(args.body)
						end,
					},
					experimental = { native_menu = true },
				})
			end,
		})

		use({
			"mfussenegger/nvim-lint",
			ft = { "bash", "sh", "lua" },
			config = function()
				require("lint").linters_by_ft = {
					sh = { "shellcheck" },
					lua = { "selene" },
				}
				autocmd([[BufWritePost <buffer> lua require'lint'.try_lint()]])
			end,
		})

		use({
			"neovim/nvim-lspconfig",
			requires = { "hrsh7th/cmp-nvim-lsp" },
			ft = { "go", "c", "cpp", "zig", "ruby", "python", "lua" },
			config = function()
				local servers = { "gopls", "zls", "pyright", "clangd", "solargraph" }
				local lsp = require("lspconfig")
				local capabilities = require("cmp_nvim_lsp").update_capabilities(
					vim.lsp.protocol.make_client_capabilities()
				)
				capabilities.textDocument.completion.completionItem.snippetSupport = true
				capabilities.textDocument.completion.completionItem.resolveSupport = {
					properties = {
						"documentation",
						"detail",
						"additionalTextEdits",
					},
				}

				local on_attach = function()
					nnoremap("<F2>", [[:lua vim.lsp.buf.rename()<CR>]])
					nnoremap("gd", [[:lua vim.lsp.buf.declaration()<CR>]])
					nnoremap("<C-]>", [[:lua vim.lsp.buf.definition()<CR>]])
					nnoremap("K", [[:lua vim.lsp.buf.hover()<CR>]])
					nnoremap("gD", [[:lua vim.lsp.buf.implementation()<CR>]])
					nnoremap("<c-k>", [[:lua vim.lsp.buf.signature_help()<CR>]])
					nnoremap("1gD", [[:lua vim.lsp.buf.type_definition()<CR>]])
					nnoremap("gr", [[:lua vim.lsp.buf.references()<CR>]])
					nnoremap("g0", [[:lua vim.lsp.buf.document_symbol()<CR>]])
					nnoremap("gW", [[:lua vim.lsp.buf.workspace_symbol()<CR>]])
					vim.cmd([[command! Format execute "lua vim.lsp.buf.formatting()"]])
					nnoremap(";f", ":Format<cr>")
				end

				for _, server in ipairs(servers) do
					lsp[server].setup({
						on_attach = on_attach,
						capabilities = capabilities,
						settings = { documentFormatting = true },
					})
				end

				-- lua specific
				local sumneko_binary_path = vim.fn.exepath("lua-language-server")
				local sumneko_root_path = vim.fn.fnamemodify(sumneko_binary_path, ":h:h:h")
				local runtime_path = vim.split(package.path, ";")
				table.insert(runtime_path, "lua/?.lua")
				table.insert(runtime_path, "lua/?/init.lua")

				lsp.sumneko_lua.setup({
					on_attach = on_attach,
					capabilities = capabilities,
					cmd = { sumneko_binary_path, "-E", sumneko_root_path .. "/main.lua" },
					settings = {
						Lua = {
							-- Tell the language server which version of
							-- Lua you're using (most likely LuaJIT in the
							-- case of Neovim)
							runtime = { version = "LuaJIT", path = runtime_path },
							diagnostics = { globals = { "vim" } },
							-- Get the language server to recognize the
							-- `vim` global

							-- Make the server aware of Neovim runtime
							-- files
							workspace = { library = vim.api.nvim_get_runtime_file("", true) },
							-- Do not send telemetry data containing a
							-- randomized but unique identifier
							telemetry = { enable = false },
						},
					},
				})
			end,
		})
	end)
end

return M
-- vim:foldmethod=indent:foldlevel=2:
