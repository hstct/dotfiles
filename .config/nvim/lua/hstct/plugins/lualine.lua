local function lsp()
    return {
        function()
            local msg = "No Active Lsp"
            local ft = vim.bo.filetype
            local clients = vim.lsp.get_active_clients()
            if next(clients) == nil then
                return msg
            end

            local clients_output = {}
            for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, ft) ~= -1 then
                    table.insert(clients_output, client.name)
                end
            end

            if #clients_output > 0 then
                return table.concat(clients_output, "/")
            else
                return msg
            end
        end,
        icon = "",
        color = { gui = "bold" },
    }
end

return {
    {
        event = "VeryLazy",
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                theme = "auto",
                component_separators = "",
                section_separators = "",
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    lsp(),
                    "branch",
                    { "diff", symbols = { added = " ", modified = "柳", removed = " " } },
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        symbols = { error = " ", warn = " ", info = " " },
                    },
                },
                lualine_c = { "filename" },
                lualine_x = { "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            tabline = {
                lualine_a = {
                    {
                        "buffers",
                        buffers_color = { active = "lualine_b_normal" },
                    },
                },
                lualine_z = {
                    {
                        "tabs",
                        tabs_color = { active = "lualine_b_normal" },
                    },
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_v = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
        },
        config = function(_, opts)
            require("lualine").setup(opts)
        end,
    },
}
