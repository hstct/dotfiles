vim.opt.laststatus = 3
require("kanagawa").setup({
  undercurl = true,
  commentStyle = {
    italic = true,
  },
  -- functionStyle = "NONE",
  keywordStyle = {
    italic = true,
  },
  statementStyle = {
    bold = true,
  },
  -- typeStyle = "NONE",
  variablebuiltinStyle = {
    italic = true,
  },
  specialReturn = true,
  specialException = true,
  transparent = false,
  dimInactive = true,
  globalStatus = true,
  colors = {},
  overrides = {},
})

vim.cmd("colorscheme kanagawa")
