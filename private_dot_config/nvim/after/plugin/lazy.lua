local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	return
end
vim.opt.rtp:prepend(lazypath)
local lazy = require("lazy")

local opts = {
	install = { missing = true, colorscheme = { "typograph" } },
}

local packages = {
	"wbthomason/packer.nvim",
	"junegunn/vim-easy-align",
	"stevearc/dressing.nvim",
	"nvim-lua/plenary.nvim",
	"elixir-editors/vim-elixir",
	"chrisgrieser/nvim-genghis",
	{ "yorickpeterse/nvim-pqf", config = true },
	{ "numToStr/Comment.nvim", config = true },
	{ "m4xshen/autoclose.nvim", config = true },
	{ "akinsho/git-conflict.nvim", config = true },
	{
		"duane9/nvim-rg",
		keys = { { "<leader>s", "<cmd>Rg<cr>", silent = true } },
	},
	{
		"ibhagwan/fzf-lua",
		config = true,
		keys = {
			{ "<c-p>", [[<cmd>lua require('fzf-lua').files()<CR>]], silent = true },
			{ "<c-y>", [[<cmd>lua require('fzf-lua').resume()<CR>]], silent = true },
			{ "<c-k>", [[<cmd>lua require('fzf-lua').commands()<CR>]], silent = true },
			{ "<c-.>", [[<cmd>lua require('fzf-lua').grep_cword()<CR>]], silent = true },
			{ "<c-g>", [[<cmd>lua require('fzf-lua').live_grep()<CR>]], silent = true },
			{ "<c-\\>", [[<cmd>lua require('fzf-lua').oldfiles()<CR>]], silent = true },
			{ "<C-x><C-f>", [[<cmd>lua require("fzf-lua").complete_path()<CR>]], silent = true, mode = "i" },
		},
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
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
			require("mason-tool-installer").setup({
				ensure_installed = { "black", "stylua", "shellcheck", "eslint_d", "shfmt" },
			})
		end,
	},

	{
		"dense-analysis/ale",
		init = function()
			vim.g.ale_disable_lsp = 1
			vim.g.ale_use_neovim_diagnostics_api = 1
			vim.g.ale_virtualtext_cursor = 0
			vim.g.ale_fixers = { lua = { "stylua" }, python = "black", ruby = "rubocop" }
		end,
		keys = { { "g=", "<cmd>ALEFix<cr>", silent = true } },
	},

	{
		"lewis6991/gitsigns.nvim",
		config = true,
		keys = {
			{ "<leader>gx", ":Gitsigns reset_hunk<cr>", silent = true },
			{ "<leader>gb", ":Gitsigns blame_line<cr>", silent = true },
			{ "<leader>gs", ":Gitsigns stage_hunk<cr>", silent = true },
			{ "<leader>gS", ":Gitsigns stage_buffer<cr>", silent = true },
			{ "<leader>gu", ":Gitsigns undo_stage_hunk<cr>", silent = true },
		},
	},
}

lazy.setup(packages, opts)
