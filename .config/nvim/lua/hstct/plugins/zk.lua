local commands = require("zk.commands")

local function make_edit_fn(defaults, picker_options)
  return function(options)
    options = vim.tbl_extend("force", defaults, options or {})
    require("zk").edit(options, picker_options)
  end
end

commands.add("ZkOrphans", make_edit_fn({ orphan = true }, { title = "Zk Orphans" }))
commands.add("ZkRecents", make_edit_fn({ creadedAfter = "2 weeks ago" }, { title = "Zk Recents" }))

require("zk").setup({
  picker = "telescope",
})

vim.keymap.set("n", "<leader>ze", "<cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>")
vim.keymap.set("n", "<leader>zn", "<cmd>ZkNew { dir = vim.fn.input('Dir: '), title = vim.fn.input('Title: ') }<CR>")
vim.keymap.set("n", "<leader>zmd", "<cmd>ZkNew { dir = vim.env.ZK_NOTEBOOK_DIR .. '/meetings/daily' }<CR>")
vim.keymap.set("n", "<leader>zmr", "<cmd>ZkNew { dir = vim.env.ZK_NOTEBOOK_DIR .. '/meetings/devrhino' }<CR>")
vim.keymap.set("n", "<leader>zmt", "<cmd>ZkNew { dir = vim.env.ZK_NOTEBOOK_DIR .. '/meetings/triage' }<CR>")
vim.keymap.set("n", "<leader>zrf", "<cmd>ZkNew { dir = vim.env.ZK_NOTEBOOK_DIR .. '/reports/feedback' }<CR>")
vim.keymap.set(
  "n",
  "<leader>zrw",
  "<cmd>ZkNew { dir = vim.env.ZK_NOTEBOOK_DIR .. '/reports/weekly', title = vim.fn.input('Title: ') }<CR>"
)
vim.keymap.set("n", "<leader>zj", "<cmd>ZkNew { dir = vim.env.ZK_NOTEBOOK_DIR .. '/journal' }<CR>")
vim.keymap.set("n", "<leader>zq", "<cmd>ZkNew { dir = vim.env.ZK_NOTEBOOK_DIR .. '/inbox' }<CR>")
vim.keymap.set(
  "n",
  "<leader>zi",
  "<cmd>ZkNew { dir = vim.env.ZK_NOTEBOOK_DIR .. '/tickets', title = vim.fn.input('Title: ') }<CR>"
)
vim.keymap.set("n", "<leader>zo", "<cmd>ZkNotes { sort = { 'modified' } }<CR>")
vim.keymap.set("n", "<leader>zt", "<cmd>ZkTags<CR>")
vim.keymap.set("n", "<leader>zf", "<cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>")
vim.keymap.set("x", "<leader>zf", ":'<,'>ZkMatch<CR>")
