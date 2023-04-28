local zk = require("zk")
local util = require("zk.util")
local commands = require("zk.commands")

zk.setup({
  picker = "telescope",
})

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true, noremap = true })
end

local function make_edit_fn(defaults, picker_options)
  return function(options)
    options = vim.tbl_extend("force", defaults, options or {})
    zk.edit(options, picker_options)
  end
end

local function make_new_fn(defaults)
  return function(options)
    options = vim.tbl_extend("force", defaults, options or {})
    zk.new(options)
  end
end

local function make_new_prompt_fn()
  return function()
    vim.ui.input({ prompt = "Note Title: " }, function(title)
      zk.new({ title = title })
    end, "New Note")
  end
end

commands.add("ZkOrphans", make_edit_fn({ orphan = true }, { title = "Zk Orphans" }))
commands.add("ZkRecents", make_edit_fn({ creadedAfter = "2 weeks ago" }, { title = "Zk Recents" }))
commands.add("ZkLiveGrep", function(options)
  options = options or {}
  local notebook_path = options.notebook_path or util.resolve_notebook_path(0)
  local notebook_root = util.notebook_root(notebook_path)
  if notebook_root then
    require("telescope.builtin").live_grep({ cwd = notebook_root, prompt_title = "Zk Live Grep" })
  else
    vim.notify("No notebook found", vim.log.levels.ERROR)
  end
end)

commands.add("ZkNewNote", make_new_prompt_fn())

commands.add("ZkNewDaily", make_new_fn({ dir = "meetings/daily" }))
commands.add("ZkDaily", make_edit_fn({ hrefs = { "meetings/daily" }, sort = { "created" } }, { title = "Zk Daily" }))

commands.add("ZkNewTicket", make_new_fn({ dir = "tickets" }))
commands.add("ZkTicket", make_edit_fn({ hrefs = "tickets", sort = { "created" } }, { title = "Zk Tickets" }))

map("n", "<leader>zn", "<cmd>ZkNewNote<CR>")
map("x", "<leader>zn", ":'<,'>ZkNewFromTitleSelection<CR>")
map("x", "<leader>zn", ":'<,'>ZkNewFromContentSelection<CR>")
map("n", "<leader>ze", "<cmd>ZkNotes { sort = { 'modified' } }<CR>")
map("n", "<leader>zp", "<cmd>ZkLiveGrep<CR>")
map("n", "<leader>zo", "<cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>")
map("n", "<leader>zb", "<cmd>ZkBacklinks<CR>")
map("n", "<leader>zl", "<cmd>ZkLinks<CR>")
map("n", "<leader>zd", "<cmd>ZkNewDaily<CR>")
map("n", "<leader>zt", "<cmd>ZkTags<CR>")

-- vim.keymap.set("n", "<leader>ze", "<cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>")
-- vim.keymap.set("n", "<leader>zn", "<cmd>ZkNew { dir = vim.fn.input('Dir: '), title = vim.fn.input('Title: ') }<CR>")
-- vim.keymap.set("n", "<leader>zmd", "<cmd>ZkNew { dir = vim.env.ZK_NOTEBOOK_DIR .. '/meetings/daily' }<CR>")
-- vim.keymap.set("n", "<leader>zmr", "<cmd>ZkNew { dir = vim.env.ZK_NOTEBOOK_DIR .. '/meetings/devrhino' }<CR>")
-- vim.keymap.set("n", "<leader>zmt", "<cmd>ZkNew { dir = vim.env.ZK_NOTEBOOK_DIR .. '/meetings/triage' }<CR>")
-- vim.keymap.set("n", "<leader>zrf", "<cmd>ZkNew { dir = vim.env.ZK_NOTEBOOK_DIR .. '/reports/feedback' }<CR>")
-- vim.keymap.set(
--   "n",
--   "<leader>zrw",
--   "<cmd>ZkNew { dir = vim.env.ZK_NOTEBOOK_DIR .. '/reports/weekly', title = vim.fn.input('Title: ') }<CR>"
-- )
-- vim.keymap.set("n", "<leader>zj", "<cmd>ZkNew { dir = vim.env.ZK_NOTEBOOK_DIR .. '/journal' }<CR>")
-- vim.keymap.set("n", "<leader>zq", "<cmd>ZkNew { dir = vim.env.ZK_NOTEBOOK_DIR .. '/inbox' }<CR>")
-- vim.keymap.set(
--   "n",
--   "<leader>zi",
--   "<cmd>ZkNew { dir = vim.env.ZK_NOTEBOOK_DIR .. '/tickets', title = vim.fn.input('Title: ') }<CR>"
-- )
-- vim.keymap.set("n", "<leader>zo", "<cmd>ZkNotes { sort = { 'modified' } }<CR>")
-- vim.keymap.set("n", "<leader>zt", "<cmd>ZkTags<CR>")
-- vim.keymap.set("n", "<leader>zf", "<cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>")
-- vim.keymap.set("x", "<leader>zf", ":'<,'>ZkMatch<CR>")
