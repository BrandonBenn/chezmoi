local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  return
end
vim.opt.rtp:prepend(lazypath)
local lazy = require("lazy")

local opts = { install = { missing = true, colorscheme = { "typograph" } } }

local packages = {
  "wbthomason/packer.nvim",
  "stevearc/dressing.nvim",
  "elixir-editors/vim-elixir",
  "chrisgrieser/nvim-genghis",
  { "yorickpeterse/nvim-pqf",    config = true },
  { "numToStr/Comment.nvim",     config = true },
  { "m4xshen/autoclose.nvim",    config = true },
  { "akinsho/git-conflict.nvim", config = true },
  { "nvim-lua/plenary.nvim",     config = function() vim.g.Job = require("plenary.job") end },

  {
    'prichrd/netrw.nvim',
    opts = {
      icons = { symlink = '', directory = '', file = '' },
      mappings = {
        ["D"] = function(payload)
          local filename = payload.dir .. "/" .. payload.node
          local trash_location = vim.fn.stdpath('state') .. "/trash/"
          local cmd = "trash"
          local args = { filename }
          local on_stderr = function(err) vim.notify(err) end

          if vim.fn.executable(cmd) ~= 1 then
            cmd = "mv"
            args = { filename, trash_location }
          end

          vim.ui.input({ prompt = 'Confirm removal (y/N): ' }, function(input)
            if input ~= "y" then return end
            vim.notify("Removed file " .. filename)
            vim.g.Job:new({ command = cmd, args = args, on_stderr = on_stderr }):sync()
            vim.cmd.mode()
          end)
        end,
      }
    }
  },

  {
    "ibhagwan/fzf-lua",
    cmd = { "FzfLua" },
    config = true,
    keys = {
      { "<c-p>",      [[<cmd>FzfLua files<CR>]],         silent = true },
      { "<c-y>",      [[<cmd>FzfLua resume<CR>]],        silent = true },
      { "<c-k>",      [[<cmd>FzfLua commands<CR>]],      silent = true },
      { "<c-.>",      [[<cmd>FzfLua grep_cword<CR>]],    silent = true },
      { "<c-g>",      [[<cmd>FzfLua live_grep<CR>]],     silent = true },
      { "<C-x><C-f>", [[<cmd>FzfLua complete_path<CR>]], silent = true, mode = "i" },
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
        function(server) lspconfig[server].setup({}) end,
      })
      require("mason-tool-installer").setup({
        ensure_installed = { "blue", "stylua", "shellcheck", "eslint_d", "shfmt" },
      })
    end,
  },

  {
    "dense-analysis/ale",
    cmd = { "ALEFix" },
    init = function()
      vim.g.ale_disable_lsp = 1
      vim.g.ale_use_neovim_diagnostics_api = 1
      vim.g.ale_virtualtext_cursor = 0
      vim.g.ale_fixers = { lua = { "stylua" }, python = { "black" }, ruby = { "rubocop" } }
    end,
    keys = { { "g=", vim.cmd.ALEFix, silent = true } },
  },

  {
    "lewis6991/gitsigns.nvim",
    cmd = "Gitsigns",
    config = true,
    keys = {
      { "<leader>gx", ":Gitsigns reset_hunk<cr>",      silent = true },
      { "<leader>gb", ":Gitsigns blame_line<cr>",      silent = true },
      { "<leader>gs", ":Gitsigns stage_hunk<cr>",      silent = true },
      { "<leader>gS", ":Gitsigns stage_buffer<cr>",    silent = true },
      { "<leader>gu", ":Gitsigns undo_stage_hunk<cr>", silent = true },
    },
  },
}

lazy.setup(packages, opts)
