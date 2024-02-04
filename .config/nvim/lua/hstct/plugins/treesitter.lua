return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "markdown" },
            },
            indent = {
                enable = true,
                disable = { "python" },
            },
            ensure_installed = {
                "bash",
                "go",
                "gomod",
                "html",
                "javascript",
                "json",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "python",
                "ruby",
                "toml",
                "tsx",
                "typescript",
                "yaml",
            },
            context_commentstring = {
                enable = true,
                enable_autocmd = false,
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                        ["uc"] = "@comment.outer",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]]"] = "@function.outer",
                    },
                    goto_previous_start = {
                        ["[["] = "@function.outer",
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>ps"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<leader>pS"] = "@parameter.inner",
                    },
                },
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
            vim.o.foldmethod = "expr"
            vim.o.foldexpr = "nvim_treesitter#foldexpr()"
            vim.o.foldlevel = 10
        end,
        build = ":TSUpdate",
        event = "BufReadPost",
    },
    { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter/nvim-treesitter" } },
}
