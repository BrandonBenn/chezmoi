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
	use("tpope/vim-eunuch")
	use("famiu/bufdelete.nvim")
	use("jghauser/mkdir.nvim")

	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			if vim.fn.has("gui_vimr") == 0 then
				require("nvim-tree").setup({
					disable_netrw = true,
					hijack_unnamed_buffer_when_opening = true,
					renderer = {
						icons = {
							webdev_colors = false,
							show = {
								file = false,
								folder = false,
							},
						},
					},
					actions = { open_file = { quit_on_open = true } },
				})
			end
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
		"mcchrish/zenbones.nvim",
		-- Optionally install Lush. Allows for more configuration or extending the colorscheme
		-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
		-- In Vim, compat mode is turned on as Lush only works in Neovim.
		requires = "rktjmp/lush.nvim",
		config = function()
			if vim.fn.has("gui_vimr") == 1 then
				vim.cmd("colorscheme zenwritten")
				vim.o.background = "light"
			end
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
