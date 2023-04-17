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
      { 'https://gitlab.com/yorickpeterse/nvim-pqf.git', as = 'pqf',   config = true },
      { 'numToStr/Comment.nvim',                         config = true },
      { 'm4xshen/autoclose.nvim',                        config = true },
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
    "luukvbaal/nnn.nvim",
    opts = {
      replace_netrw = "picker",
      picker = { style = { border = "rounded", width = 0.35, xoffset = 0.9 } },
    },
    keys = {
      { '<leader>v', ':NnnPicker<cr>', silent = true }
    }
  },

  {
    'lewis6991/gitsigns.nvim',
    init = function()
      vim.opt.titlestring = [[%t%( %M%)%( (%{expand("%:~:.:h")})%)%( %a%) %{get(b:,'gitsigns_head','')}]]
    end,
    config = true,
    keys = {
      { '<leader>gR', ":Gitsigns reset_hunk<cr>",   silent = true },
      { '<leader>gb', ":Gitsigns blame_line<cr>",   silent = true },
      { '<leader>gs', ":Gitsigns stage_hunk<cr>",   silent = true },
      { '<leader>gS', ":Gitsigns stage_buffer<cr>", silent = true },
      { "<leader>gl", ":term git log<cr>",          silent = true },
    },
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
