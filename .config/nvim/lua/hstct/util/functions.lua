local M = {}

function M.map(m, k, v, opts)
    opts = opts or { silent = true }
    vim.keymap.set(m, k, v, opts)
end

return M
