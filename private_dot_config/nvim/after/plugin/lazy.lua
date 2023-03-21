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
      'vim-test/vim-test',
      { 'https://gitlab.com/yorickpeterse/nvim-pqf.git', as = 'pqf', config = true },
      { 'numToStr/Comment.nvim', config = true },
      { 'm4xshen/autoclose.nvim', config = true },
    },
  },

  {
    -- Fuzzy Finder
    'nvim-telescope/telescope.nvim',
    dependencies = { { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim' } },
    config = function()
      local layout = require('telescope.actions.layout')
      local builtin = require('telescope.builtin')
      require("telescope").load_extension("ui-select")

      require('telescope').setup {
        defaults = {
          preview = { hide_on_startup = true },
          mappings = {
            i = { ['<M-p>'] = layout.toggle_preview },
            n = { ['<M-p>'] = layout.toggle_preview },
          },
        },
        pickers = {
          find_files = { theme = 'dropdown' },
          git_files = { theme = 'dropdown' },
          oldfiles = { theme = 'dropdown', only_cwd = true },
        },
      }

      vim.keymap.set('n', '<C-p><C-p>', function()
        vim.fn.system('git rev-parse --is-inside-work-tree')
        if vim.v.shell_error == 0 then
          builtin.git_files()
        else
          builtin.find_files()
        end
      end, { silent = true })

      vim.keymap.set('n', '<C-p>o', builtin.oldfiles, { silent = true })
      vim.keymap.set('n', '<C-p>w', builtin.grep_string, { silent = true })
      vim.keymap.set('n', '<C-p>r', builtin.resume, { silent = true })
      vim.keymap.set('n', '<C-p>f', builtin.live_grep, { silent = true })
    end
  },

  {
    'lewis6991/gitsigns.nvim',
    config = function()
      local gitsigns = require('gitsigns')
      gitsigns.setup()
      vim.keymap.set('n', '<leader>gR', gitsigns.reset_hunk, { silent = true })
      vim.keymap.set('n', '<leader>gb', gitsigns.blame_line, { silent = true })
      vim.keymap.set('n', '<leader>gs', gitsigns.stage_hunk, { silent = true })
      vim.keymap.set('n', '<leader>gS', gitsigns.stage_buffer, { silent = true })
    end
  },

  {
    -- Terminal
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup({
        open_mapping = [[<C-T>]],
        direction = 'tab',
      })
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit  = Terminal:new({ cmd = 'NO_COLOR=1 lazygit', direction = 'tab', hidden = true })
      vim.keymap.set('n', '<leader>gg', function() lazygit:toggle() end, { noremap = true, silent = true })
    end
  },

  {
    'willothy/flatten.nvim',
    config = true,
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
      lsp.setup()
      lsp.ensure_installed({
        'gopls',
        'ruff_lsp',
        'solargraph',
        'sumneko_lua',
      })


      local cmp = require('cmp')
      cmp.setup(
        lsp.defaults.cmp_config({
          window = { completion = cmp.config.window.bordered() },
          sources = {
            { name = 'luasnip' },
            { name = 'nvim_lsp' },
            { name = 'buffer' },
            { name = 'rg' },
            { name = 'path' },
            { name = 'nvim_lua' },
          },
        })
      )
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
    dependencies = { 'nvim-treesitter/playground' },
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
      require("rest-nvim").setup({result_split_horizontal = true})
    end,
    keys = {
      { "<C-c><C-c>", require("rest-nvim").run, desc = "Run the request under the cursor" },
    }
  },

  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua" },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
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
