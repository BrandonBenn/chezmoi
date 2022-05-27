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
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "g", function()
	hs.window.focusedWindow():centerOnScreen()
end)

switcher = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter({}))
switcher.ui.textSize = 16
switcher.ui.fontName = "Arial"
switcher.ui.titleBackgroundColor = { 0.3, 0.3, 0.3, 1 }
switcher.ui.showTitles = true
switcher.ui.showSelectedTitle = false
switcher.ui.showSelectedThumbnail = false

hs.hotkey.bind("alt", "tab", function()
	switcher:next()
end)

hs.hotkey.bind("alt-shift", "tab", function()
	switcher:previous()
end)

require("bluetooth_sleep").init()
require("commandq").init()
require("clipboard").init({ enable_hotkey = true })
require("caffeine").init()
