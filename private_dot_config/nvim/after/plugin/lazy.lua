local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then return end
vim.opt.rtp:prepend(lazypath)
local lazy = require("lazy")

local opts = {
  install = { missing = true, colorscheme = { "typograph" } },
  border = "single",
}

local packages = {
  "wbthomason/packer.nvim",
  "nvim-lua/plenary.nvim",
  "stevearc/dressing.nvim",
  "chrisgrieser/nvim-genghis",

  {
    "ggandor/lightspeed.nvim",
    dependencies = { "tpope/vim-repeat" }
  },

  { "elixir-editors/vim-elixir", ft = "elixir" },
  { "yorickpeterse/nvim-pqf",    config = true },
  { "numToStr/Comment.nvim",     config = true },
  { "m4xshen/autoclose.nvim",    config = true },

  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip"
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-l>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
        }, {
          { name = 'buffer' },
        })
      })

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = 'buffer' } }
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
      })
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    config = true,
    event = "BufEnter",
    keys = {
      { '<leader>gb', '<cmd>Gitsigns blame_line<cr>',   silent = true, desc = "[G]it [B]lame" },
      { '<leader>gs', '<cmd>Gitsigns stage_hunk<cr>',   silent = true, desc = "[G]it [S]tage" },
      { '<leader>gx', '<cmd>Gitsigns reset_hunk<cr>',   silent = true, desc = "[G]it [X]Reset" },
      { '<leader>gX', '<cmd>Gitsigns reset_buffer<cr>', silent = true, desc = "[G]it [X]Reset Buffer" },
      { ']c',         '<cmd>Gitsigns next_hunk<cr>',    silent = true, desc = "[G]it [N]ext Hunk" },
      { '[c',         '<cmd>Gitsigns prev_hunk<cr>',    silent = true, desc = "[G]it [P]rev Hunk" },
    }
  },

  {
    "tpope/vim-fugitive",
    cmd = "Git",
    keys = { { '<leader>gg', '<cmd>Git<cr>', silent = true, desc = "[G]it" } },
  },

  {
    "MeanderingProgrammer/harpoon-core.nvim",
    config = true,
    keys = {
      { 'mm', function() require('harpoon-core.ui').toggle_quick_menu() end, desc = "Harpoon Quick [M]enu" },
      { 'mz', function() require('harpoon-core.mark').add_file() end,        desc = "Harpoon [A]dd File" },
      { 'mx', function() require('harpoon-core.mark').rm_file() end,         desc = "Harpoon [R]emove File" },
      { 'ma', function() require('harpoon-core.ui').nav_file(1) end,         desc = "Harpoon File [1]" },
      { 'ms', function() require('harpoon-core.ui').nav_file(2) end,         desc = "Harpoon File [2]" },
      { 'md', function() require('harpoon-core.ui').nav_file(3) end,         desc = "Harpoon File [3]" },
      { 'mf', function() require('harpoon-core.ui').nav_file(4) end,         desc = "Harpoon File [4]" },
      { 'mg', function() require('harpoon-core.ui').nav_file(5) end,         desc = "Harpoon File [5]" },
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    cmd = { 'Telescope' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local action_layout = require("telescope.actions.layout")
      require('telescope').setup {
        defaults = require('telescope.themes').get_dropdown({
          mappings = {
            n = {
              ["p"] = action_layout.toggle_preview,
              ["<C-u>"] = false,
            },
            i = {
              ["<C-u>"] = false,
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
      { '<leader>fb', '<cmd>Telescope buffers<cr>',                   silent = true, desc = "[F]ind [B]uffer" },
      { '<leader>fr', '<cmd>Telescope resume<cr>',                    silent = true, desc = "[F]ind [R]esume" },
      { '<leader>fp', '<cmd>Telescope git_files<cr>',                 silent = true, desc = "[F]ind [P]roject Files" },
      { '<leader>ff', '<cmd>Telescope find_files<cr>',                silent = true, desc = "[F]ind [F]iles" },
      { '<leader>fo', '<cmd>Telescope oldfiles<cr>',                  silent = true, desc = "[F]ind [O]ld Files" },
      { '<leader>fw', '<cmd>Telescope grep_string<cr>',               silent = true, desc = "[F]ind [W]ord" },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>',                 silent = true, desc = "[F]ind [G]rep" },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>',                 silent = true, desc = "[F]ind [H]elp" },
      { '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>', silent = true, desc = "[F]ind [S]earch" },
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
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require("mason").setup({})
      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers({
        function(server) lspconfig[server].setup({ capabilities = capabilities }) end,
      })

      require("mason-tool-installer").setup({
        ensure_installed = {
          "isort", "black", "ruff", "stylua", "shellcheck", "eslint_d", "prettier", "shfmt",
        },
      })
    end,
  },

  {
    'stevearc/conform.nvim',
    event = "BufEnter",
    config = true,
    opts = {
      formatters_by_ft = {
        -- lua = { "stylua" },
        python = { 'isort', 'black' },
        sh = { 'shfmt' },
        javascript = { 'prettier', 'eslint_d' },
      },
    },
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
