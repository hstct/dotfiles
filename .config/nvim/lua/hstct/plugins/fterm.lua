require("FTerm").setup({
  border = "rounded",
  dimensions = {
    height = 0.9,
    width = 0.9,
  },
})

vim.keymap.set("n", "<A-i>", "<CMD>lua require('FTerm').toggle()<CR>")
vim.keymap.set("t", "<A-i>", "<C-\\><C-n><CMD>lua require('FTerm').toggle()<CR>")
vim.keymap.set(
  "n",
  "<A-g>",
  "<CMD>lua require('FTerm'):new({ cmd = { 'lazygit' }, border = 'rounded', dimensions = { height = 0.9, width = 0.9 } }):open()<CR>"
)
