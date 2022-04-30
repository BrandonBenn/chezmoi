require("paq")({
	"famiu/bufdelete.nvim",
	"lewis6991/gitsigns.nvim",
	"TimUntersberger/neogit",
	"sindrets/diffview.nvim",
	"jghauser/mkdir.nvim",
	"famiu/bufdelete.nvim",
	"akinsho/toggleterm.nvim",
	"jose-elias-alvarez/null-ls.nvim",
	"norcalli/nvim-colorizer.lua",
	"neovim/nvim-lspconfig",
	"nvim-treesitter/nvim-treesitter",
	"numToStr/Comment.nvim",
	"github/copilot.vim",
	"lukas-reineke/indent-blankline.nvim",
	"ms-jpq/coq.artifacts",
	"ms-jpq/coq.thirdparty",
	{
		"ms-jpq/coq_nvim",
		run = function()
			require("coq").deps()
		end,
	},
	"nvim-telescope/telescope.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
	"tpope/vim-eunuch",
	"justinmk/vim-dirvish",
	"roginfarrer/vim-dirvish-dovish",
	"windwp/nvim-autopairs",
	"lewis6991/impatient.nvim",
	"rcarriga/nvim-notify",
	"kchmck/vim-coffee-script",
	"nvim-lua/popup.nvim",
	"nvim-lua/plenary.nvim",
	"savq/paq-nvim",
})
