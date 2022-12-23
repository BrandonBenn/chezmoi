vim.cmd.packadd("packer.nvim")
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
	use("tpope/vim-eunuch")
	use("tpope/vim-vinegar")
	use("tpope/vim-fugitive")
	use("famiu/bufdelete.nvim")
	use("jghauser/mkdir.nvim")
	use("samjwill/nvim-unception")
	use("Olical/conjure")
	use({
		"ThePrimeagen/harpoon",
		config = function()
			local rails_cmds = { "foreman start", "rails server", "rails console" }

			require("harpoon").setup({
				global_settings = {
					enter_on_sendcmd = true,
					mark_branch = true,
				},
				projects = {
					["$HOME/Git/keybridge"] = { term = { cmds = rails_cmds } },
				},
			})
		end,
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
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
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

	use({
		"zbirenbaum/copilot.lua",
		requires = {
			{ "github/copilot.vim", opt = true },
		},
		event = "InsertEnter",
		config = function()
			vim.schedule(function()
				require("copilot").setup({
					copilot_node_command = vim.fn.expand("~/.asdf/installs/nodejs/lts/bin/node"),
				})
			end)
		end,
	})

	use({
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	})
end)
