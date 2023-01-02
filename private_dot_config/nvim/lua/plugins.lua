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
		'camspiers/snap',
		config = function()
			local snap = require("snap")

			local finder = snap.config.file:with {
				prompt = " ", reverse = true, layout = snap.get('layout').bottom
			}

			snap.maps({
				{ "<C-p><C-p>", finder { try = { "git.file", "ripgrep.file" } } },
				{ "<C-p>o", finder { producer = "vim.oldfile" } },
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
				'ruby_ls',
				'eslint',
				'sumneko_lua',
			})
			lsp.setup()
		end
	}

	-- AI Helper
	use {
		'zbirenbaum/copilot.lua',
		requires = {
			{ 'github/copilot.vim', opt = true },
		},
		event = 'InsertEnter',
		config = function()
			vim.schedule(function()
				require('copilot').setup({
					copilot_node_command = vim.fn.expand('~/.asdf/installs/nodejs/lts/bin/node'),
				})
			end)
		end,
	}

end)
