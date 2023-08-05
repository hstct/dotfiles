local A = vim.api
local hstct_au = A.nvim_create_augroup("HSTCT", { clear = true })

-- Highlight the region on yank
A.nvim_create_autocmd("TextYankPost", {
    group = hstct_au,
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual" })
    end,
})
