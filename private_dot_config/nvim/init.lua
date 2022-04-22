local function ensure(repo, path)
	assert(repo)
	local path = path or "paqs"
	local author, plugin = vim.fn.split(repo, "/")[1], vim.fn.split(repo, "/")[2]
	local install_path = vim.fn.stdpath('data') .. string.format('/site/pack/%s/start/%s', path, plugin)
	if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
		vim.fn.system({ 'git', 'clone', '--depth', '1',
		string.format('https://github.com/%s/%s', author, plugin),
		install_path
	})
	end
	vim.cmd(string.format("packadd %s", plugin))
end

ensure("savq/paq-nvim.git")
dofile(vim.fn.expand("~/.config/nvim/deps.lua"))
for _, module in pairs(vim.split(vim.fn.glob('~/.config/nvim/modules/*.lua'), '\n')) do
  pcall(dofile, module)
end
