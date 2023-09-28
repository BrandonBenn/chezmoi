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
  "tpope/vim-fugitive",
  { "elixir-editors/vim-elixir", ft = "elixir" },
  { "yorickpeterse/nvim-pqf",    config = true },
  { "numToStr/Comment.nvim",     config = true },
  { "m4xshen/autoclose.nvim",    config = true },
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
  },

  {
    'nvim-telescope/telescope.nvim',
    cmd = { 'Telescope' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local action_layout = require("telescope.actions.layout")
      local actions = require("telescope.actions")
      require('telescope').setup {
        defaults = require('telescope.themes').get_dropdown({
          mappings = {
            n = {
              ["p"] = action_layout.toggle_preview,
              ["<C-u>"] = false,
            },
            i = {
              ["<C-u>"] = false,
              ["<esc>"] = actions.close,
              ["<M-p>"] = action_layout.toggle_preview,
            },
          }
        }),
        pickers = {
          buffers = { previewer = false },
          find_files = { previewer = false },
          current_buffer_fuzzy_find = { previewer = false },
        },
      }
    end,
    keys = {
      { '<leader>fb', '<cmd>Telescope buffers<cr>',                   silent = true },
      { '<leader>ff', '<cmd>Telescope find_files<cr>',                silent = true },
      { '<leader>fo', '<cmd>Telescope oldfiles<cr>',                  silent = true },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>',                 silent = true },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>',                 silent = true },
      { '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>', silent = true },
    },
  },

  {
    "stevearc/oil.nvim",
    config = true,
    keys = { { "-", vim.cmd.Oil, silent = true, desc = "Open parent directory" } },
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
      ensure_installed = { "go", "html", "javascript", "python", "ruby", "sql", "vue", "lua" },
    },
  },
}

lazy.setup(packages, opts)
