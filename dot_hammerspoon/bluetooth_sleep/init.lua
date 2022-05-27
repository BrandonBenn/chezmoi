require("string")

local M = {}

function check_bluetooth_result(rc, stderr, stderr)
	if rc ~= 0 then
		print(string.format("Unexpected result executing `blueutil`: rc=%d stderr=%s stdout=%s", rc, stderr, stdout))
	end
end

function bluetooth(power)
	print("Setting bluetooth to " .. power)
	local task = hs.task.new("/usr/local/bin/blueutil", check_bluetooth_result, { "--power", power })
	task:start()
end

function f(event)
	if event == hs.caffeinate.watcher.systemWillSleep then
		bluetooth("off")
	elseif event == hs.caffeinate.watcher.screensDidWake then
		bluetooth("on")
	end
end

function M.init()
	hs.caffeinate.watcher.new(f):start()
	watcher = hs.caffeinate.watcher.new(f)
	watcher:start()
end

return M
