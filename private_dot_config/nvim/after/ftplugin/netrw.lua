local utils = require("utils")
vim.keymap.set("n", "D", utils.delete_under_cursor, { silent = true, buffer = true })
