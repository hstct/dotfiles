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
