hs.window.animationDuration = 0

-- function to maximize current window on the left
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "j", function()
	hs.window.focusedWindow():moveToUnit(hs.geometry.rect(0, 0, 0.5, 1))
end)

-- function to maximize current window on the right
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "l", function()
	hs.window.focusedWindow():moveToUnit(hs.geometry.rect(0.5, 0, 0.5, 1))
end)

-- function to maximize current window
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "i", function()
	hs.window.focusedWindow():maximize()
end)

-- function to center current window
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "k", function()
	hs.window.focusedWindow():centerOnScreen()
end)

switcher = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter({}))
switcher.ui.showTitles = false
switcher.ui.thumbnailSize = 200
switcher.ui.showSelectedThumbnail = false
switcher.ui.backgroundColor = { 0, 0, 0, 0.8 }
switcher.ui.highlightColor = { 0.3, 0.3, 0.3, 0.8 }

function mapCmdTab(event)
	local flags = event:getFlags()
	local chars = event:getCharacters()
	if chars == "\t" and flags:containExactly({ "cmd" }) then
		switcher:next()
		return true
	elseif chars == string.char(25) and flags:containExactly({ "cmd", "shift" }) then
		switcher:previous()
		return true
	end
end
tapCmdTab = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, mapCmdTab)
tapCmdTab:start()

require("bluetooth_sleep").init()
require("commandq").init()
require("clipboard").init({ enable_hotkey = true })
require("caffeine").init()
