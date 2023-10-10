local keymap = require("utils").keymap

-- Set Keymaps
keymap("n", ";w", vim.cmd.update)
keymap("n", "<c-w>q", function()
  local multiple_windows, _ = pcall(vim.cmd, "close")
  if not multiple_windows then
    vim.cmd("bd")
  end
end)
keymap("c", "<c-n>", "<down>", { remap = true })
keymap("c", "<c-p>", "<up>", { remap = true })
keymap("c", "<c-a>", "<home>", { remap = true })
keymap("c", "<c-e>", "<end>", { remap = true })
keymap("c", "<c-b>", "<left>", { remap = true })
keymap("c", "<c-f>", "<right>", { remap = true })

keymap("n", "+", '<cmd>resize +10<cr>', { remap = true })
keymap("n", "_", '<cmd>resize -10<cr>', { remap = true })

keymap("n", "<C-w>t", vim.cmd.tabnew)
keymap("n", "<Tab>", vim.cmd.tabnext)
keymap("n", "<S-Tab>", vim.cmd.tabprevious)
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")
keymap("n", "<C-t><C-t>", ":tabnew | terminal<cr>")
keymap("n", "<C-t>v", ":vsplit | terminal<cr>")
keymap("n", "<C-t>s", ":split | terminal<cr>")
keymap("n", "[d", vim.diagnostic.goto_prev)
keymap("n", "]d", vim.diagnostic.goto_next)
keymap("n", "gl", function()
  vim.diagnostic.open_float({ scope = "line" })
end)
keymap("n", "<leader>q", vim.diagnostic.setqflist)
