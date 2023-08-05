local bar = "┃"
local has_git_dir = function()
    local dirs = vim.fs.find(".git", { upward = true, type = "directory" })
    return #dirs > 0
end

return {
    { "tpope/vim-fugitive", cond = has_git_dir },
    { "tpope/vim-rhubarb",  cond = has_git_dir, dependencies = { "tpope/vim-fugitive" } },
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        cond = has_git_dir,
        opts = {
            numhl = true,
            signs = {
                add = { text = bar },
                change = { text = bar },
                delete = { text = bar },
                topdelete = { text = bar },
                changedelete = { text = bar },
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                map("n", "]c", function()
                    if vim.wo.diff then
                        return "]c"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, desc = "git: next hunk" })

                map("n", "[c", function()
                    if vim.wo.diff then
                        return "[c"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, desc = "git: prev hunk" })

                map({ "n", "v" }, "<leader>hs", gs.stage_hunk, { desc = "git: stage hunk" })
                map({ "n", "v" }, "<leader>hr", gs.reset_hunk, { desc = "git: reset hunk" })
                map("n", "<leader>hS", gs.stage_buffer, { desc = "git: stage buffer" })
                map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "git: undo stage hunk" })
                map("n", "<leader>hR", gs.reset_buffer, { desc = "git: reset buffer" })
                map("n", "<leader>hp", gs.preview_hunk, { desc = "git: preview hunk" })
                map("n", "<leader>hb", function()
                    gs.blame_line({ full = true })
                end, { desc = "git: blame line" })
                map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "git: toggle line blame" })
                map("n", "<leader>hd", gs.diffthis, { desc = "git: diff file" })
                map("n", "<leader>hD", function()
                    gs.diffthis("~")
                end, { desc = "git: diff project" })
                map("n", "<leader>td", gs.toggle_deleted, { desc = "git: toggle deleted" })

                map({ "o", "x" }, "ih", ":<C-U>GitSigns select_hunk<CR>", { desc = "textobject: select hunk" })
            end,
        },
    },
}
