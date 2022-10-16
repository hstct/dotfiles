require("harpoon").setup()

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

map("n", "<C-h>", function()
  require("harpoon.mark").add_file()
end)

map("n", "<C-e>", function()
  require("harpoon.ui").toggle_quick_menu()
end)

map("n", "'q", function()
  require("harpoon.ui").nav_file(1)
end)
map("n", "'w", function()
  require("harpoon.ui").nav_file(2)
end)
map("n", "'e", function()
  require("harpoon.ui").nav_file(3)
end)
map("n", "'r", function()
  require("harpoon.ui").nav_file(4)
end)
