local actions = require("telescope.actions")
local lactions = require("telescope.actions.layout")
local finders = require("telescope.builtin")

require("telescope").setup({
  defaults = {
    prompt_prefix = " ❯ ",
    initial_mode = "insert",
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top",
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
  },
  extenstions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

local Telescope = setmetatable({}, {
  __index = function(_, k)
    if vim.bo.filetype == "NvimTree" then
      vim.cmd.wincmd("l")
    end
    return finders[k]
  end,
})

vim.keymap.set("n", "<C-p>", function()
  local ok = pcall(Telescope.git_files, { show_untracked = true })
  if not ok then
    Telescope.find_files()
  end
end)
vim.keymap.set("n", "<leader>H", Telescope.help_tags)
vim.keymap.set("n", "'b", Telescope.buffers)
vim.keymap.set("n", "'r", Telescope.live_grep)
vim.keymap.set("n", "'c", Telescope.git_status)

vim.keymap.set("n", "<leader>fb", Telescope.buffers)
vim.keymap.set("n", "<leader>ft", Telescope.live_grep)
vim.keymap.set("n", "<leader>fg", Telescope.git_status)
vim.keymap.set("n", "<leader>ff", Telescope.find_files)
