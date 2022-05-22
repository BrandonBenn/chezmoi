--[[
   From https://github.com/victorso/.hammerspoon/blob/master/tools/clipboard.lua
   Modified by Diego Zamboni

   This is my attempt to implement a jumpcut replacement in Lua/Hammerspoon.
   It monitors the clipboard/pasteboard for changes, and stores the strings you copy to the transfer area.
   You can access this history on the menu (Unicode scissors icon).
   Clicking on any item will add it to your transfer area.
   If you open the menu while pressing option/alt, you will enter the Direct Paste Mode. This means that the selected item will be
   "typed" instead of copied to the active clipboard.
   The clipboard persists across launches.
   -> Ng irc suggestion: hs.settings.set("jumpCutReplacementHistory", clipboard_history)
]]
--

-- Feel free to change those settings
local frequency = 0.8 -- Speed in seconds to check for clipboard changes. If you check too frequently, you will loose performance, if you check sparsely you will loose copies
local hist_size = 20 -- How many items to keep on history
local label_length = 40 -- How wide (in characters) the dropdown menu should be. Copies larger than this will have their label truncated and end with "…" (unicode for elipsis ...)
local honor_clearcontent = true --asmagill request. If any application clears the pasteboard, we also remove it from the history https://groups.google.com/d/msg/hammerspoon/skEeypZHOmM/Tg8QnEj_N68J
local paste_on_select = false -- Auto-type on click

-- Don't change anything bellow this line
local jumpcut = hs.menubar.new()

jumpcut:setTooltip("Clipboard History")
local pasteboard = require("hs.pasteboard") -- http://www.hammerspoon.org/docs/hs.pasteboard.html
local settings = require("hs.settings") -- http://www.hammerspoon.org/docs/hs.settings.html
local last_change = pasteboard.changeCount() -- displays how many times the pasteboard owner has changed // Indicates a new copy has been made

--Array to store the clipboard history
local clipboard_history = settings.get("so.victor.hs.jumpcut") or {}

function set_title()
	jumpcut:setTitle("✄")
end

function put_on_paste(string, key)
	place_at_front(string)
	if paste_on_select then
		hs.eventtap.keyStrokes(string)
		pasteboard.setContents(string)
		last_change = pasteboard.changeCount()
	else
		if key and key.alt == true then -- If the option/alt key is active when clicking on the menu, perform a "direct paste", without changing the clipboard
			hs.eventtap.keyStrokes(string) -- Defeating paste blocking http://www.hammerspoon.org/go/#pasteblock
		else
			pasteboard.setContents(string)
			last_change = pasteboard.changeCount() -- Updates last_change to prevent item duplication when putting on paste
		end
	end
end

-- Clears the clipboard and history
function clear_all()
	pasteboard.clearContents()
	clipboard_history = {}
	settings.set("so.victor.hs.jumpcut", clipboard_history)
	now = pasteboard.changeCount()
	set_title()
end

-- Clears the last added to the history
function clear_last_item()
	table.remove(clipboard_history, #clipboard_history)
	settings.set("so.victor.hs.jumpcut", clipboard_history)
	now = pasteboard.changeCount()
	set_title()
end

function pasteboard_to_clipboard(item)
	-- Loop to enforce limit on qty of elements in history. Removes the oldest items
	while #clipboard_history >= hist_size do
		table.remove(clipboard_history, 1)
	end

	place_at_front(item)
	settings.set("so.victor.hs.jumpcut", clipboard_history) -- updates the saved history
	set_title() -- updates the menu counter
end

function place_at_front(item)
	for i, value in ipairs(clipboard_history) do
		if value == item then
			table.remove(clipboard_history, i)
		end
	end
	table.insert(clipboard_history, item)
end

-- Dynamic menu by cmsj https://github.com/Hammerspoon/hammerspoon/issues/61#issuecomment-64826257
function populate_menu(key)
	set_title() -- Update the counter every time the menu is refreshed
	menu_data = {}
	if #clipboard_history == 0 then
		table.insert(menu_data, { title = "None", disabled = true }) -- If the history is empty, display "None"
	else
		for k, v in pairs(clipboard_history) do
			if string.len(v) > label_length then
				table.insert(menu_data, 1, {
					title = string.sub(v, 0, label_length) .. "…",
					fn = function()
						put_on_paste(v, key)
					end,
				}) -- Truncate long strings
			else
				table.insert(menu_data, 1, {
					title = v,
					fn = function()
						put_on_paste(v, key)
					end,
				})
			end -- end if else
		end -- end for
	end -- end if else

	-- footer
	table.insert(menu_data, { title = "-" })
	table.insert(menu_data, {
		title = "Clear All",
		fn = function()
			clear_all()
		end,
	})
	if key.alt == true or paste_on_select then
		table.insert(menu_data, { title = "Direct Paste Mode ✍", disabled = true })
	end
	return menu_data
end

-- If the pasteboard owner has changed, we add the current item to our history and update the counter.
function store_copy()
	now = pasteboard.changeCount()
	if now > last_change then
		current_clipboard = pasteboard.getContents()
		-- It prevents the history from keeping items removed by password managers
		if current_clipboard == nil and true then
			clear_last_item()
		else
			pasteboard_to_clipboard(current_clipboard)
		end
		last_change = now
	end
end

chooser = hs.chooser.new(function(choice)
	if choice then
		put_on_paste(choice.content, nil)
	end
end)

local M = {}

--Checks for changes on the pasteboard. Is it possible to replace with eventtap?
function M.init(opts)
	local opts = opts or { enable_hotkey = true }
	timer = hs.timer.new(frequency, store_copy)
	timer:start()

	set_title() --Avoid wrong title if the user already has something on his saved history
	jumpcut:setMenu(populate_menu, nil)

	if opts.enable_hotkey == true then
		hs.hotkey.bind({ "cmd", "option" }, "v", function()
			local choices = {}
			for k, v in pairs(clipboard_history) do
				table.insert(choices, 1, {
					["text"] = string.sub(v, 0, label_length) .. "…",
					["content"] = v,
				})
			end

			chooser:choices(choices)
			chooser:show()
		end)
	end
end

return M
