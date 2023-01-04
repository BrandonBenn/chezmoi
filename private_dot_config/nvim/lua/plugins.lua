vim.cmd.packadd('packer.nvim')

require('packer').startup(function(use)
	-- Editing Support
	use {
		'wbthomason/packer.nvim',
		requires = {
			'junegunn/vim-easy-align',
			'numToStr/Comment.nvim',
			'm4xshen/autoclose.nvim',
		},
		config = function()
			require('Comment').setup()
			require('autoclose').setup({})
		end
	}

	use {
		'nvim-telescope/telescope.nvim',
		requires = { { 'nvim-lua/plenary.nvim' } },
		config = function()
			local layout = require("telescope.actions.layout")
			local builtin = require("telescope.builtin")

			require('telescope').setup {
				defaults = {
					preview = { hide_on_startup = true },
					mappings = {
						i = { ["<M-p>"] = layout.toggle_preview },
						n = { ["<M-p>"] = layout.toggle_preview },
					},
				},
				pickers = {
					find_files = { theme = "dropdown" },
					git_files = { theme = "dropdown" },
					oldfiles = { theme = "dropdown", only_cwd = true },
					live_grep = { theme = "ivy" },
					grep_string = { theme = "ivy" },
				},
			}

			vim.keymap.set("n", "<C-p><C-p>", function()
				vim.fn.system("git rev-parse --is-inside-work-tree")
				if vim.v.shell_error == 0 then
					builtin.git_files()
				else
					builtin.find_files()
				end
			end, { silent = true })

			vim.keymap.set('n', '<C-p>o', builtin.oldfiles, { silent = true })
			vim.keymap.set('n', '<C-p>w', builtin.grep_string, { silent = true })
			vim.keymap.set("n", "<C-p>r", builtin.resume, { silent = true })
			vim.keymap.set('n', '<C-p>f', builtin.live_grep, { silent = true })
		end
	}

	use {
		'nvim-treesitter/nvim-treesitter',
		config = function()
			require('nvim-treesitter.configs').setup({
				ensure_installed = { "ruby", "lua", "javascript", "vue" },
			})
		end
	}

	-- IDE functionality
	use {
		'VonHeikemen/lsp-zero.nvim',
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' },
			{ 'williamboman/mason.nvim' },
			{ 'williamboman/mason-lspconfig.nvim' },

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'saadparwaiz1/cmp_luasnip' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-nvim-lua' },

			-- Snippets
			{ 'L3MON4D3/LuaSnip' },
			{ 'rafamadriz/friendly-snippets' },
		},
		config = function()
			local lsp = require('lsp-zero')
			lsp.preset('recommended')
			lsp.ensure_installed({
				'eslint',
				'sumneko_lua',
			})
			lsp.setup()
		end
	}

	-- AI Helper
	use {
		'zbirenbaum/copilot.lua',
		event = 'VimEnter',
		config = function()
			vim.defer_fn(function()
				require('copilot').setup({
					copilot_node_command = vim.fn.expand('~/.asdf/installs/nodejs/lts/bin/node'),
				})
			end, 100)
		end,
	}
end)
