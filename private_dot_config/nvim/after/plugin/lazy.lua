local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	return
end
vim.opt.rtp:prepend(lazypath)
local lazy = require("lazy")

local opts = { install = { missing = true, colorscheme = { "typograph" } } }

local packages = {
	"wbthomason/packer.nvim",
	"nvim-lua/plenary.nvim",
	"stevearc/dressing.nvim",
	"justinmk/vim-dirvish",
	"tpope/vim-unimpaired",
	"chrisgrieser/nvim-genghis",
	{ "elixir-editors/vim-elixir", ft = "elixir" },
	{ "yorickpeterse/nvim-pqf", config = true },
	{ "numToStr/Comment.nvim", config = true },
	{ "m4xshen/autoclose.nvim", config = true },
	{ "akinsho/git-conflict.nvim", config = true },
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		config = true,
		keys = {
			{ "<leader>gx", ":Gitsigns reset_hunk<cr>", silent = true },
			{ "<leader>gb", ":Gitsigns blame_line<cr>", silent = true },
			{ "<leader>gs", ":Gitsigns stage_hunk<cr>", silent = true },
			{ "<leader>gS", ":Gitsigns stage_buffer<cr>", silent = true },
			{ "<leader>gu", ":Gitsigns undo_stage_hunk<cr>", silent = true },
		},
	},

	{
		"ibhagwan/fzf-lua",
		cmd = { "FzfLua" },
		config = true,
		opts = { winopts = { height = 0.30, width = 0.4, preview = { hidden = "hidden" } } },
		keys = {
			{
				"<leader>ff",
				function()
					require("fzf-lua").files()
				end,
				silent = true,
			},
			{
				"<leader>fo",
				function()
					require("fzf-lua").oldfiles()
				end,
				silent = true,
			},
			{
				"<leader>fk",
				function()
					require("fzf-lua").commands()
				end,
				silent = true,
			},
			{
				"<leader>fw",
				function()
					require("fzf-lua").grep_cword()
				end,
				silent = true,
			},
			{
				"<leader>fb",
				function()
					require("fzf-lua").buffers()
				end,
				silent = true,
			},
			{
				"<leader>fg",
				function()
					require("fzf-lua").live_grep({ continue_last_search = true })
				end,
				silent = true,
			},
			{
				"<C-x><C-f>",
				function()
					require("fzf-lua").complete_path()
				end,
				silent = true,
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"creativenull/efmls-configs-nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")
			require("mason").setup({})
			require("mason-lspconfig").setup()
			require("mason-lspconfig").setup_handlers({
				function(server)
					lspconfig[server].setup({})
				end,
			})

			local ensure_installed = { "efm", "black", "stylua", "shellcheck", "eslint_d", "shfmt" }
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			local languages = require("efmls-configs.defaults").languages()
			languages = vim.tbl_extend("force", languages, {
				python = { require("efmls-configs.formatters.black") },
				html = { require("efmls-configs.formatters.prettier") },
				sh = { require("efmls-configs.formatters.shfmt"), require("efmls-configs.linters.shellcheck") },
			})

			lspconfig.efm.setup({
				settings = {
					rootMarkers = { ".git/", "manage.py", "Gemfile" },
					languages = languages,
				},
				filetypes = vim.tbl_keys(languages),
				init_options = { documentFormatting = true, documentRangeFormatting = true },
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		config = true,
		opts = {
			ensure_installed = { "go", "html", "javascript", "python", "ruby", "sql", "vue" },
		},
	},
}

lazy.setup(packages, opts)
