local M = {}

--@return string
local function get_appearance(appearance)
  if appearance:find('Dark') then
    return 'Grayscale Dark (base16)'
  else
    return 'Grayscale Light (base16)'
  end
end

--@param window Window
--@param _ pane Pane
function M.set_appearance(window, _)
  local overrides = window:get_config_overrides() or {}
  local appearance = window:get_appearance()
  overrides.color_scheme = get_appearance(appearance)
  window:set_config_overrides(overrides)
end

return M
