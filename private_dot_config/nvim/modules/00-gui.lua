vim.o.guifont = "JetBrains Mono"
vim.g.guifontsize = 12

if vim.fn.has("macunix") == 1 then
	vim.g.neovide_transparency = 0.0
	vim.g.transparency = 0.9
	vim.cmd([[let g:neovide_background_color = '#1c1c1c'.printf('%x', float2nr(255 * g:transparency))]])
end

local adjust_fontsize = function(size)
	vim.g.guifontsize = vim.g.guifontsize + size
	local font = vim.split(vim.o.guifont, ":")[1]
	vim.o.guifont = font .. ":h" .. vim.g.guifontsize
end

vim.keymap.set({ "n", "i", "x" }, "<D-=>", function()
	adjust_fontsize(2)
end, { noremap = true })

vim.keymap.set({ "n", "i", "x" }, "<D-->", function()
	adjust_fontsize(-2)
end, { noremap = true })

vim.keymap.set({ "v" }, "<D-c>", [["+y"]], { noremap = true })
vim.keymap.set({ "i", "n", "x" }, [[<D-v>]], [["+p"]], { noremap = true })
vim.keymap.set({ "c" }, "<D-v>", [[<C-r>+]], { noremap = true })
