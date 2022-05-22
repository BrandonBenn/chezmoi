-- Press Cmd+Q twice to quit

local M = {}
local quitModal = hs.hotkey.modal.new("cmd", "q")

function quitModal:entered()
	hs.alert.show("Press ⌘+Q again to quit", 1)
	hs.timer.doAfter(1, function()
		quitModal:exit()
	end)
end

M.init = function()
	quitModal:bind("cmd", "q", function()
		local res = hs.application.frontmostApplication():selectMenuItem("^Quit.*$")
		quitModal:exit()
	end)

	quitModal:bind("", "escape", function()
		quitModal:exit()
	end)
end

return M
