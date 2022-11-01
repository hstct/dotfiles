local A = vim.api

vim.filetype.add({
  extenstion = {
    eslintrc = "json",
    prettierrc = "json",
    conf = "conf",
    mdx = "markdown",
    mjml = "html",
  },
  pattern = {
    [".*%.env.*"] = "sh",
    ["ignore$"] = "conf",
  },
  filename = {
    ["yup.lock"] = "yaml",
  },
})

local hst_au = A.nvim_create_augroup("HSTCT", { clear = true })

-- Highlight the region on yank
A.nvim_create_autocmd("TextYankPost", {
  group = hst_au,
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual" })
  end,
})

-- Remove useless stuff from the terminal window and enter INSERT mode
A.nvim_create_autocmd("TermOpen", {
  group = hst_au,
  callback = function(data)
    if not string.find(vim.bo[data.buf].filetype, "^[fF][tT]erm") then
      A.nvim_set_option_value("number", false, { scope = "local" })
      A.nvim_set_option_value("relativenumber", false, { scope = "local" })
      A.nvim_set_option_value("signcolumn", "no", { scope = "local" })
      A.nvim_command("startinsert")
    end
  end,
})
