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
      'elixir-editors/vim-elixir',
      'chrisgrieser/nvim-genghis',
      'duane9/nvim-rg',
      { 'yorickpeterse/nvim-pqf', config = true },
      { 'numToStr/Comment.nvim',  config = true },
      { 'm4xshen/autoclose.nvim', config = true },
    },
  },

  {
    'tamago324/lir.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    enable = false,
    lazy = false,
    config = true,
    keys = {
      { '-',         ':edit %:p:h<cr>',           silent = true },
      { '<leader>v', ':vsplit | edit  %:p:h<cr>', silent = true },
    },
    opts = {
      mappings = {
        ['<cr>']  = function() require('lir.actions').edit() end,
        ['<C-s>'] = function() require('lir.actions').split() end,
        ['<C-v>'] = function() require('lir.actions').vsplit() end,
        ['<C-t>'] = function() require('lir.actions').tabedit() end,
        ['-']     = function() require('lir.actions').up() end,
        ['q']     = function() require('lir.actions').quit() end,
        ['a']     = function() require('lir.actions').newfile() end,
        ['A']     = function() require('lir.actions').mkdir() end,
        ['r']     = function() require('lir.actions').rename() end,
        ['@']     = function() require('lir.actions').cd() end,
        ['Y']     = function() require('lir.actions').yank_path() end,
        ['.']     = function() require('lir.actions').toggle_show_hidden() end,
        ['D']     = function() require('lir.actions').delete() end,
        ['y']     = function() require('lir.clipboard.actions').copy() end,
        ['x']     = function() require('lir.clipboard.actions').cut() end,
        ['p']     = function() require('lir.clipboard.actions').paste() end,
      }
    },
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
      { '<leader>fo', function() require('telescope.builtin').oldfiles({ previewer = false }) end,   silent = true },
      { '<leader>fw', function() require('telescope.builtin').grep_string() end,                     silent = true },
      { '<leader>fg', function() require('telescope.builtin').live_grep() end,                       silent = true },
      { '<leader>fr', function() require('telescope.builtin').resume() end,                          silent = true },
      { '<leader>ff', function() require('telescope.builtin').find_files({ previewer = false }) end, silent = true },
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
      { '<leader>gx', ":Gitsigns reset_hunk<cr>",                          silent = true },
      { '<leader>gb', ":Gitsigns blame_line<cr>",                          silent = true },
      { '<leader>gs', ":Gitsigns stage_hunk<cr>",                          silent = true },
      { '<leader>gu', ":Gitsigns undo_stage_hunk<cr>",                     silent = true },
      { '<leader>gS', ":Gitsigns stage_buffer<cr>",                        silent = true },
      { '<leader>gp', ':belowright split | terminal git push<cr>',         silent = true },
      { '<leader>gP', ':belowright split | terminal git push --force<cr>', silent = true },
      { '<leader>gf', ':belowright split | terminal git pull<cr>',         silent = true },
      { '<leader>gF', ':belowright split | terminal git fetch<cr>',        silent = true },
    },
  },

  {
    'akinsho/git-conflict.nvim',
    version = "*",
    config = true,
    opts = {
      default_mappings = {
        ours = 'o',
        theirs = 't',
        none = 'x',
        both = 'b',
        next = 'n',
        prev = 'p',
      },
    },
  },

  {
    'akinsho/toggleterm.nvim',
    version = "*",
    dependencies = { { 'willothy/flatten.nvim', config = true } },
    opts = { open_mapping = [[<c-z>]] },
    init = function()
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit  = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "tab",
        float_opts = { border = "double" },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
        on_close = function(_)
          vim.cmd("startinsert!")
        end,
      })

      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end
    end,
    keys = {
      { '<leader>gg', "<cmd>lua _LAZYGIT_TOGGLE()<CR>", silent = true },
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
    init = function()
      local mason = require('mason-tool-installer')
      mason.setup({
        'black',
        'shellcheck',
      })
    end,
    config = function()
      local null_ls = require('null-ls')
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
        ensure_installed = {
          'ruby', 'python', 'lua',
          'javascript', 'vue', 'json',
          'http', 'go', 'sql',
        },
      })
    end
  },

  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua" },
    ft = { "go", 'gomod' },
    config = true,
  },
}, opts)
