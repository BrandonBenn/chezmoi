local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then return end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    -- Editing Support
    'wbthomason/packer.nvim',
    dependencies = {
      'junegunn/vim-easy-align',
      'Olical/conjure',
      { 'numToStr/Comment.nvim', config = true },
      { 'm4xshen/autoclose.nvim', config = true },
      { 'lukas-reineke/indent-blankline.nvim', config = true },
    },
  },

  {
    -- Fuzzy Finder
    'nvim-telescope/telescope.nvim',
    dependencies = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      local layout = require('telescope.actions.layout')
      local builtin = require('telescope.builtin')

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

  { 'lewis6991/gitsigns.nvim', config = true }, -- Inline Git Functionality

  {
    -- Terminal
    'akinsho/toggleterm.nvim', tag = '*',
    config = function()
      require('toggleterm').setup()
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit  = Terminal:new({ cmd = 'NO_COLOR=1 lazygit', direction = 'float', hidden = true })

      vim.keymap.set('n', '<leader>gg', function() lazygit:toggle() end, { noremap = true, silent = true })
    end
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
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      -- Snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local lsp = require('lsp-zero')
      lsp.preset('recommended')
      lsp.ensure_installed({
        'sumneko_lua',
      })

      lsp.configure('solargraph', { settings = { cmd = vim.fn.expand('~/.asdf/shims/solargraph') } })
      lsp.setup()
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'ruby', 'python', 'lua', 'javascript', 'vue' },
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
    -- Linter
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require('null-ls')
      null_ls.setup({
        sources = {
          null_ls.builtins.completion.spell,
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.formatting.eslint_d,
          null_ls.builtins.formatting.trim_whitespace,
        },
      })
    end
  },

  {
    -- AI Helper
    'zbirenbaum/copilot.lua',
    event = 'VimEnter',
    config = function()
      vim.defer_fn(function()
        require('copilot').setup({
          copilot_node_command = vim.fn.expand('~/.asdf/installs/nodejs/lts/bin/node'),
        })
      end, 100)
    end,
  },
})
