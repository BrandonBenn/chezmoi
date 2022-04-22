local keymap = vim.keymap.set
local merge = vim.tbl_deep_extend

local layout = require "telescope.actions.layout"
local actions = require "telescope.actions"
require "telescope".load_extension 'fzf'
require "telescope".setup {
    defaults = merge('force', require "telescope.themes".get_dropdown(), {
      preview = {hide_on_startup = true},
      layout_config = {
          height = function(_, _, lines) return math.min(lines, 15) end, 
          width = function(_, _, cols) return math.min(cols, 60) end
      },
      path_display = {'smart'},
      extensions = {
          fzf = { fuzzy = true },
          override_file_sorter = true,
          override_generic_sorter = true
      },
      mappings = {
          n = { 
              ['<M-p>'] = layout.toggle_preview,
              ['d'] = pcall(actions.delete_buffer)
          },
          i = {
              ['<M-p>'] = layout.toggle_preview,
              ['<C-d>'] = pcall(actions.delete_buffer)
          },
      },
  })
}

local builtin = require "telescope.builtin"
local finder = function()
    if not pcall(builtin.git_files) then
        builtin.find_files()
    end
end
keymap('n', '<C-p>', finder, {silent = true})
keymap('n', '<leader>ff', finder, {silent = true})
keymap('n', '<leader>fo', builtin.oldfiles, {silent = true})
keymap('n', '<leader>fr', builtin.resume, {silent = true})
keymap('n', '<leader>fb', builtin.buffers, {silent = true})
keymap('n', '<leader>fg', builtin.live_grep, {silent = true})
keymap('n', '<leader>fw', builtin.grep_string, {silent = true})
