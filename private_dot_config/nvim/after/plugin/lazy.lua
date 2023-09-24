local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then return end
vim.opt.rtp:prepend(lazypath)
local lazy = require("lazy")

local opts = { install = { missing = true, colorscheme = { "typograph" } } }

local packages = {
  "wbthomason/packer.nvim",
  "nvim-lua/plenary.nvim",
  "stevearc/dressing.nvim",
  "chrisgrieser/nvim-genghis",
  { "elixir-editors/vim-elixir", ft = "elixir" },
  { "yorickpeterse/nvim-pqf",    config = true },
  { "numToStr/Comment.nvim",     config = true },
  { "m4xshen/autoclose.nvim",    config = true },
  { "akinsho/git-conflict.nvim", config = true },

  {
    "stevearc/oil.nvim",
    config = true,
    keys = { { "-", vim.cmd.Oil, silent = true, desc = "Open parent directory" } },
  },

  {
    "tpope/vim-fugitive",
    keys = { { "<leader>gg", vim.cmd.Git, silent = true, desc = "Git status" } },
  },

  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = true,
    keys = {
      { "<leader>gx", ":Gitsigns reset_hunk<cr>",      silent = true, desc = "Git reset hunk" },
      { "<leader>gb", ":Gitsigns blame_line<cr>",      silent = true, desc = "Git blame line" },
      { "<leader>gs", ":Gitsigns stage_hunk<cr>",      silent = true, desc = "Git stage hunk" },
      { "<leader>gS", ":Gitsigns stage_buffer<cr>",    silent = true, desc = "Git stage buffer" },
      { "<leader>gu", ":Gitsigns undo_stage_hunk<cr>", silent = true, desc = "Git undo stage buffer" },
    },
  },

  {
    "ibhagwan/fzf-lua",
    cmd = { "FzfLua" },
    config = true,
    opts = { winopts = { height = 0.30, width = 0.4, preview = { hidden = "hidden" } } },
    keys = {
      { "<leader>ff", "<cmd>FzfLua files<cr>",         silent = true, desc = "Find Files" },
      { "<leader>fo", "<cmd>FzfLua oldfiles<cr>",      silent = true, desc = "Find Old fles" },
      { "<leader>fk", "<cmd>FzfLua commands<cr>",      silent = true, desc = "Find commands" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>",       silent = true, desc = "Find buffers" },
      { "<leader>fw", "<cmd>FzfLua grep_cword<cr>",    silent = true, desc = "Grep Word" },
      { "<C-x><C-f>", "<cmd>FzfLua complete_path<cr>", silent = true, desc = "Complete Path" },
      {
        "<leader>fg",
        function()
          require("fzf-lua").live_grep({ continue_last_search = true })
        end,
        silent = true,
        desc = "Live Grep",
      },
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
        ensure_installed = { "ruff", "stylua", "shellcheck", "eslint_d", "prettier" },
      })
    end,
  },

  {
    "dense-analysis/ale",
    init = function()
      vim.g.ale_fix_on_save = 1
      vim.g.ale_use_neovim_diagnostics_api = 1
      vim.g.ale_fixers = {
        python = { "ruff" },
        javascript = { "prettier", "eslint_d" },
        sh = { "shellcheck" }
      }
    end
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
