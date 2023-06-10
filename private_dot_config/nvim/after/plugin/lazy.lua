local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then return end
vim.opt.rtp:prepend(lazypath)

local opts = {
  install = { missing = true, colorscheme = { 'typograph' } }
}

require('lazy').setup({
  {
    -- Editing Support
    'wbthomason/packer.nvim',
    dependencies = {
      'junegunn/vim-easy-align',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'vim-test/vim-test',
      { 'yorickpeterse/nvim-pqf', config = true },
      { 'numToStr/Comment.nvim',  config = true },
      { 'm4xshen/autoclose.nvim', config = true },
    },
  },

  { "chrisgrieser/nvim-genghis" },

  {
    "stevearc/oil.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "stevearc/dressing.nvim",
    },
    config = true,
    keys = {
      { "-", function() require("oil").open() end, desc = "Open parent directory", silent = true },
    }
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    opts = {
      defaults = {
        layout_strategy = 'center',
        sorting_strategy = "ascending",
      },
    },
    keys = {
      { '<c-p><c-o>', function() require('telescope.builtin').oldfiles() end,                        silent = true },
      { '<c-p><c-g>', function() require('telescope.builtin').grep_string() end,                     silent = true },
      { '<c-p><c-r>', function() require('telescope.builtin').resume() end,                          silent = true },
      { '<c-p><c-p>', function() require('telescope.builtin').find_files({ previewer = false }) end, silent = true },
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    event = 'BufEnter',
    init = function()
      vim.opt.titlestring = [[%t%( %M%)%( (%{expand("%:~:.:h")})%)%( %a%) %{get(b:,'gitsigns_head','')}]]
    end,
    config = true,
    keys = {
      { '<leader>gx', ":Gitsigns reset_hunk<cr>",      silent = true },
      { '<leader>gb', ":Gitsigns blame_line<cr>",      silent = true },
      { '<leader>gs', ":Gitsigns stage_hunk<cr>",      silent = true },
      { '<leader>gu', ":Gitsigns undo_stage_hunk<cr>", silent = true },
      { '<leader>gS', ":Gitsigns stage_buffer<cr>",    silent = true },
    },
  },

  {
    'tpope/vim-fugitive',
    cmd = 'Git',
    keys = {
      { '<leader>gg', ':tab G<cr>',                        silent = true },
      { '<leader>gC', ':Git commit --amend --no-edit<cr>', silent = true },
      { '<leader>gP', ':Git push --force<cr>',             silent = true },
      { '<leader>gF', ':Git pull<cr>',                     silent = true },
    }
  },

  {
    'akinsho/toggleterm.nvim',
    version = "*",
    dependencies = {
      { 'willothy/flatten.nvim', config = true }
    },
    opts = {
      open_mapping = [[<c-g>]],
    }
  },

  {
    -- IDE Functionality
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
      -- LSP Support
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      -- Autocompletion
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'hrsh7th/nvim-cmp',
      'lukas-reineke/cmp-rg',
      'saadparwaiz1/cmp_luasnip',
      -- Snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local lsp = require('lsp-zero')
      lsp.preset('recommended')

      lsp.ensure_installed({
        'gopls',
        'ruff_lsp',
      })

      local cmp = require('cmp')
      lsp.setup_nvim_cmp({
        window = { completion = cmp.config.window.bordered() },
        sources = {
          { name = 'luasnip',  keyword_length = 3 },
          { name = 'nvim_lsp', keyword_length = 2 },
          { name = 'buffer' },
          { name = 'rg' },
          { name = 'path' },
          { name = 'nvim_lua' },
        },
      })
      lsp.setup()
    end
  },

  {
    -- Linter
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    config = function()
      local mason = require('mason-tool-installer')
      local null_ls = require('null-ls')

      mason.setup({
        'black',
        'shellcheck',
      })

      null_ls.setup({
        sources = {
          null_ls.builtins.completion.spell,
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.eslint_d,
          null_ls.builtins.formatting.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }),
          null_ls.builtins.formatting.trim_whitespace,
        },
      })
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'ruby', 'python', 'lua', 'javascript', 'vue', 'json', 'http', 'go', 'sql' },
      })

      require('nvim-treesitter.configs').setup({
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<CR>',
            node_incremental = '<CR>',
            scope_incremental = '<S-CR>',
            node_decremental = '<BS>',
          },
        },
      })
    end
  },

  {
    "rest-nvim/rest.nvim",
    requires = { 'nvim-lua/plenary.nvim' },
    ft = "http",
    config = function()
      require("rest-nvim").setup({ result_split_horizontal = true, result_split_in_place = 'below' })
    end,
    keys = {
      { "<C-c><C-c>", "<Plug>RestNvim", desc = "Run the request under the cursor" },
    }
  },

  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua" },
    config = true,
    ft = { "go", 'gomod' },
  },

  {
    -- AI Helper
    'zbirenbaum/copilot.lua',
    event = 'BufEnter',
    config = function()
      require('copilot').setup({
        copilot_node_command = vim.fn.expand('~/.local/share/rtx/installs/nodejs/18.15.0/bin/node')
      })
    end,
  },
}, opts)
