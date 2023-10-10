local M = {}

M.keymap = function(mode, cmd, keys, options)
  local opts = options or { remap = true, silent = true }
  vim.keymap.set(mode, cmd, keys, opts)
end

return M
