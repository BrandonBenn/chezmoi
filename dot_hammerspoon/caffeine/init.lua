local M = {}
local caffeine = hs.menubar.new()

function setCaffeineDisplay(state)
	local result
	if state then
		result = caffeine:setTitle('☕')
	else
		result = caffeine:setTitle('🫖')
	end
end

function M.init()
	if caffeine then
		caffeine:setClickCallback(function()
			setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
		end)
		setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
	end
end

return M
