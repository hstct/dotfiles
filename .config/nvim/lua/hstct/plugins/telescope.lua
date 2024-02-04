return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    init = function()
        local tb = require("telescope.builtin")
        local ta = require("telescope.actions")
        local tas = require("telescope.actions.state")
        local u = require("hstct.util.functions")

        local function files_wiki()
            tb.find_files({
                prompt_title = "Wiki files",
                cwd = '~/.local/wiki',
                disable_devicons = true,
                find_command = { "rg", "--files", "--sort", "path" },
                file_ignore_patterns = {
                    "%journal/",
                    "%.stversions/",
                    "%.git/",
                },
                path_display = function(_, path)
                    local name = path:match "(.+)%.[^.]+$"
                    return name or path
                end,
                attach_mappings = function(prompt_bufnr, _)
                    ta.select_default:replace_if(function()
                        return tas.get_selected_entry() == nil
                    end, function()
                        ta.close(prompt_bufnr)

                        local new_name = tas.get_current_line()
                        if new_name == nil or new_name == "" then
                            return
                        end

                        vim.fn["wiki#page#open"](new_name)
                    end)

                    return true
                end,
            })
        end

        local function files_journal()
            tb.find_files({
                prompt_title = "Journal files",
                cwd = "~/.local/wiki/journal",
                disable_devicons = true,
                find_command = { "rg", "--files", "--sort", "path" },
                file_ignore_patterns = {
                    "%.stversions/",
                    "%.git/",
                },
                path_display = function(_, path)
                    local name = path:match "(.+)%.[^.]+$"
                    return name or path
                end,
                attach_mappings = function(prompt_bufnr, _)
                    ta.select_default:replace_if(function()
                        return tas.get_selected_entry() == nil
                    end, function()
                        ta.close(prompt_bufnr)
                        local new_name = tas.get_current_line()
                        if new_name == nil or new_name == "" then
                            return
                        end

                        vim.fn["wiki#page#open"](new_name)
                    end)
                    return true
                end,
            })
        end

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
        u.map("n", "<leader>zp", files_wiki, { desc = "telescope: wiki files" })
        u.map("n", "<leader>zj", files_journal, { desc = "telescope: journal files" })

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
    end,
}
