vim.opt_local.conceallevel = 2
vim.opt_local.textwidth = 0
vim.opt_local.linebreak = true

local u = require("hstct.util.functions")
u.map("n", "<leader>sc", "<cmd>lua vim.opt_local.conceallevel = 2<CR>", { desc = "markdown: reset conceallevel "})
