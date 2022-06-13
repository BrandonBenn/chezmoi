local bootstrap = function(repo, opts)
	assert(repo)
	local opts = opts or {}
	local path = opts.path or "paqs"
	local author, plugin = vim.fn.split(repo, "/")[1], vim.fn.split(repo, "/")[2]
	local install_path = vim.fn.stdpath("data") .. string.format("/site/pack/%s/start/%s", path, plugin)
	if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
		vim.fn.system({
			"git",
			"clone",
			"--depth",
			"10",
			string.format("https://github.com/%s/%s", author, plugin),
			install_path,
		})
	end
	-- checkout commit
	if opts.commit then
		vim.fn.system({
			"git",
			"-C",
			install_path,
			"checkout",
			opts.commit,
		})
	end
	vim.cmd(string.format("packadd %s", plugin))
end

bootstrap("savq/paq-nvim", { commit = "2db3fbe" })
dofile(vim.fn.expand("~/.config/nvim/deps.lua"))
for _, module in pairs(vim.split(vim.fn.glob("~/.config/nvim/modules/*.lua"), "\n")) do
	dofile(module)
end
