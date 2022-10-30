require("packer").startup(function(use)
	use({ "wbthomason/packer.nvim", requires = {
		"nvim-lua/plenary.nvim",
		"nvim-lua/popup.nvim",
	} })

	use("elixir-editors/vim-elixir")
	use("neovim/nvim-lspconfig")
	use("jose-elias-alvarez/null-ls.nvim")
	use("nvim-treesitter/nvim-treesitter")
	use("junegunn/vim-easy-align")
	use("ThePrimeagen/harpoon")

	use({
		"tpope/vim-vinegar",
		requires = {
			"tpope/vim-eunuch",
			"famiu/bufdelete.nvim",
			"jghauser/mkdir.nvim",
		},
	})

	use({
		"numToStr/Comment.nvim",
		requires = {
			"windwp/nvim-autopairs",
			"lukas-reineke/indent-blankline.nvim",
		},
		event = "BufEnter",
		config = function()
			require("Comment").setup()
			require("nvim-autopairs").setup()
			require("indent_blankline").setup()
		end,
	})

	use({ "nvim-telescope/telescope.nvim", requires = { "nvim-telescope/telescope-smart-history.nvim" } })
	use({
		"lewis6991/gitsigns.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})

	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"lukas-reineke/cmp-rg",
		},
	})

	use({
		"williamboman/mason.nvim",
		requires = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()
		end,
	})

	use({ "github/copilot.vim", opt = true })

	use({
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		config = function()
			vim.schedule(function()
				require("copilot").setup({
					copilot_node_command = vim.fn.expand("~/.asdf/installs/nodejs/16.17.0/bin/node"),
				})
			end)
		end,
	})
end)
