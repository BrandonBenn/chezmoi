--@param mode string|table
--@param cmd string|function
--@param keys string|table
--@param options table
--@return nil
local function keymap(mode, cmd, keys, options)
  local opts = options or { remap = true, silent = true }
  vim.keymap.set(mode, cmd, keys, opts)
end

return { keymap = keymap }
