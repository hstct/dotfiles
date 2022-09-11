require("neogit").setup({
    disable_commit_confirmation = true,
    kind = "split",
    signs = {
        section = { "", "" },
        item = { "", "" },
        hunk = { "", "" },
    },
})
