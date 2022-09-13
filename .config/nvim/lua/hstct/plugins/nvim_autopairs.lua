require("nvim-autopairs").setup({
  disable_filetype = { "TelescopePrompt" },
  break_line_filetype = nil,
  html_break_line_filetype = {
    "html",
    "vue",
    "typescriptreact",
    "svelte",
    "javascriptreact",
  },
  ignored_next_char = "[%w%%%'%[%\"%.]",
  enable_check_bracket_line = false,
  check_ts = true,
})

-- integration w/ nvim-cmp
require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
