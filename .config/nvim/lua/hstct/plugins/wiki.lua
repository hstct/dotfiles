return {
    {
        "lervag/wiki.vim",
        cond = vim.loop.cwd() ~= "/home/hstct/Wiki/dolmenwood",
        init = function()
            vim.g.wiki_root = "~/.local/wiki"
            vim.g.wiki_filetypes = { "md" }
            vim.g.wiki_mappings_local = {
                ["<plug>(wiki-link-transform-operator)"] = "gL",
            }
            vim.g.wiki_toc_depth = 2
            vim.g.wiki_ui_method = {
                confirm = "nvim",
                input = "nvim",
                select = "nvim",
            }
            vim.g.wiki_templates = {
                {
                    match_func = function(ctx)
                        return ctx.path:find "journal/"
                    end,
                    source_filename = "~/.local/wiki/.templates/journal.md"
                }
            }
        end,
    },
}
