local wez = require("wezterm")
local download_link = "https://git.sr.ht/~technomancy/fennel/blob/main/bootstrap/fennel.lua"

local ok, fennel = pcall(require, "fennel")
if not ok then
    -- download file to cache dir using http library
    local path = ".cache/wezterm"
    wez.run_child_process({"curl", "-L", download_link, "-o", wez.config_dir .. "/fennel.lua"})
    package.path = package.path .. ";" .. wez.config_dir
    -- require fennel
    fennel = require("fennel")
end

fennel.path = fennel.path .. ";.config/wezterm/fnl/?.fnl"
table.insert(package.loaders or package.searchers, fennel.searcher)
return require("init")

