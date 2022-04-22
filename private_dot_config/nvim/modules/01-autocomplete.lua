vim.g.coq_settings = { 
    auto_start = 'shut-up',
    display = { icons = { mode = 'none' } }
}
require("coq")
require("coq_3p") { { src = "copilot", short_name = "COP", accept_key = "<c-f>" } } 
require('nvim-autopairs').setup{}
