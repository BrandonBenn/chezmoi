-- Setup nvim-cmp.
vim.defer_fn(function()
	local cmp = require("cmp")
	cmp.setup({
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-r>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "rg" },
			{ name = "path" },
		}, { { name = "buffer" } }),
		experimental = {
			native_menu = false,
			ghost_text = true,
		},
	})
end, 1500)
