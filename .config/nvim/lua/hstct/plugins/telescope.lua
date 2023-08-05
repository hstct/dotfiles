return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
        "ThePrimeagen/harpoon",
    },
    init = function()
        local tb = require("telescope.builtin")
        local u = require("hstct.util.functions")
        u.map("n", "<C-p>", function()
            local ok = pcall(tb.git_files, { show_untracked = true })
            if not ok then
                tb.find_files()
            end
        end, { desc = "telescope: find files" })
        u.map("n", "<leader>ft", tb.live_grep, { desc = "telescope: live grep" })
        u.map("n", "<leader>fb", tb.buffers, { desc = "telescope: buffers" })
        u.map("n", "<leader>fg", tb.git_status, { desc = "telescope: git status" })
        u.map("n", "<leader>fk", tb.keymaps, { desc = "telescope: keymaps" })
        u.map("n", "<leader>H", tb.help_tags, { desc = "telescope: help tags" })

        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        u.map("n", "<C-h>", mark.add_file, { desc = "harpoon: add file" })
        u.map("n", "<C-e>", ui.toggle_quick_menu, { desc = "harpoon: toggle quick menu" })
        u.map("n", "'1", function() ui.nav_file(1) end, { desc = "harpoon: nav file 1" })
        u.map("n", "'2", function() ui.nav_file(2) end, { desc = "harpoon: nav file 2" })
        u.map("n", "'3", function() ui.nav_file(3) end, { desc = "harpoon: nav file 3" })
        u.map("n", "'4", function() ui.nav_file(4) end, { desc = "harpoon: nav file 4" })
    end,
    config = function()
        local t = require("telescope")
        local actions = require("telescope.actions")
        local lactions = require("telescope.actions.layout")
        t.setup {
            defaults = {
                prompt_prefix = " ❯ ",
                initial_mode = "insert",
                sorting_strategy = "ascending",
                layout_config = {
                    prompt_position = "top",
                    preview_width = 0.6,
                },
            },
            mappings = {
                i = {
                    ["<ESC>"] = actions.close,
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<TAB>"] = actions.toggle_selection + actions.move_selection_next,
                    ["<C-s>"] = actions.send_selected_to_qflist,
                    ["<C-q>"] = actions.send_to_qflist,
                    ["<C-h>"] = lactions.toggle_preview,
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        }
        t.load_extension("fzf")
        t.load_extension("harpoon")

        require("harpoon").setup()
    end,
}
