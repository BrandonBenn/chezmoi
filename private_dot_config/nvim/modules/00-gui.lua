
if not (vim.fn.exists("g:neovide") == 1 or vim.fn.exists("GuiFont") == 1) then
	return
end

if vim.fn.exists("g:neovide") == 1 then
	vim.g.neovide_transparency = 0.0
	vim.g.transparency = 0.9
	vim.env.EDITOR = "neovide --nofork"
	vim.env.GIT_EDITOR = vim.env.EDITOR
end

vim.o.guifont = "JetBrains Mono"
vim.g.guifontsize = 10
vim.o.background = "dark"

function toggle_background()
	local background_color = ""
	if vim.o.background == "light" then
		background_color = "#000000"
		vim.o.background = "dark"
	else
		background_color = "#ffffff"
		vim.o.background = "light"
	end

	vim.cmd("colorscheme typograph")
	if vim.fn.exists("g:neovide") == 1 then
		vim.cmd(
			[[let g:neovide_background_color = ']]
				.. background_color
				.. [['.printf('%x', float2nr(255 * g:transparency))]]
		)
	end
end

vim.api.nvim_create_user_command("ToggleBackground", toggle_background, {})
toggle_background()

local adjust_fontsize = function(size)
	vim.g.guifontsize = vim.g.guifontsize + size
	local font = vim.split(vim.o.guifont, ":")[1]
	vim.o.guifont = font .. ":h" .. vim.g.guifontsize
end

vim.keymap.set({ "n" }, "<C-Tab>", ":tabnext<CR>", { noremap = true })
vim.keymap.set({ "n" }, "<CS-Tab>", ":tabprev<CR>", { noremap = true })

if vim.fn.has("macunix") == 1 then
	vim.keymap.set({ "n", "i", "x" }, "<D-t>", ":tabnew<CR>", { noremap = true })
	vim.keymap.set({ "n", "i", "x" }, "<D-w>", ":tabclose<CR>", { noremap = true })
	vim.keymap.set({ "n", "i", "x" }, "<D-=>", function()
		adjust_fontsize(1)
	end, { noremap = true })

	vim.keymap.set({ "n", "i", "x" }, "<D-->", function()
		adjust_fontsize(-1)
	end, { noremap = true })

	vim.keymap.set({ "v" }, "<D-c>", [["+y"]], { noremap = true })
	vim.keymap.set({ "n" }, "<D-v>", [["+p]], { noremap = true })
	vim.keymap.set({ "i" }, "<D-v>", [[<C-o>"+p]], { noremap = true })
	vim.keymap.set({ "c" }, "<D-v>", [[<C-r>+]], { noremap = true })
else
	vim.keymap.set({ "n", "i", "x" }, "<C-=>", function()
		adjust_fontsize(1)
	end, { noremap = true })

	vim.keymap.set({ "n", "i", "x" }, "<C-->", function()
		adjust_fontsize(-1)
	end, { noremap = true })

	vim.keymap.set({ "v" }, "<CS-c>", [["+y"]], { noremap = true })
	vim.keymap.set({ "n" }, "<CS-v>", [["+p]], { noremap = true })
	vim.keymap.set({ "i" }, "<CS-v>", [[<C-o>"+p]], { noremap = true })
	vim.keymap.set({ "c" }, "<CS-v>", [[<C-r>+]], { noremap = true })
end
