local function ensure(repo, path)
	assert(repo)
	local path = path or "paqs"
	local fn = vim.fn
	local author  = fn.split(repo, "/")[1]
	local plugin = fn.split(repo, "/")[2]
	local fmt = string.format
	local install_path = fn.stdpath('data') .. fmt('/site/pack/%s/start/%s', path, plugin)
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({
		'git', 
		'clone',
		'--depth',
		'1',
		fmt('https://github.com/%s/%s', author, plugin),
		install_path
	})
	end
	vim.cmd(fmt("packadd %s", plugin))
end

ensure("rktjmp/hotpot.nvim")
ensure("bakpakin/fennel.vim")
ensure("savq/paq-nvim.git")

require "hotpot"
require "init"
