local servers = { "solargraph", "zls", "clangd" }

local lspconfig = require("lspconfig")
local null_ls = require("null-ls")
local treesitter = require("nvim-treesitter.configs")

local map = vim.keymap.set
local flags = { debounce_text_changes = 150 }
local on_attach = function(client, buffer)
	vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
	map("n", "gd", vim.lsp.buf.definition, { buffer = buffer, silent = true })
	map("n", "gD", vim.lsp.buf.declaration, { buffer = buffer, silent = true })
	map("n", "K", vim.lsp.buf.hover, { buffer = buffer, silent = true })
	map("n", "gi", vim.lsp.buf.implementation, { buffer = buffer, silent = true })
	map("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = buffer, silent = true })
	map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { buffer = buffer, silent = true })
	map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { buffer = buffer, silent = true })
	map("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = buffer, silent = true })
	map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = buffer, silent = true })
	map("n", "ga", vim.lsp.buf.code_action, { buffer = buffer, silent = true })
	map("n", "gr", vim.lsp.buf.references, { buffer = buffer, silent = true })
	map("n", "<leader>e", vim.diagnostic.open_float, { buffer = buffer, silent = true })
	map("n", "[d", vim.diagnostic.goto_next, { buffer = buffer, silent = true })
	map("n", "]d", vim.diagnostic.goto_prev, { buffer = buffer, silent = true })
	map("n", "<leader>q", vim.diagnostic.setloclist, { buffer = buffer, silent = true })
end

for _, server in pairs(servers) do
	lspconfig[server].setup({ on_attach = on_attach, flags = flags })
end

null_ls.setup({
	sources = {
		null_ls.builtins.completion.spell,
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.diagnostics.proselint,
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.eslint_d,
		null_ls.builtins.formatting.prettier.with({ "html", "json", "markdown" }),
	},
})

treesitter.setup({
	ensure_installed = { "ruby", "lua", "vue", "zig" },
	sync_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
})
