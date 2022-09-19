require("treesitter-context").setup({
  enable = true,
  max_lines = 0,
  trim_scope = "outer",
  min_window_height = 0,
  patterns = {
    default = {
      "function",
      "method",
      "for",
      "while",
      "if",
      "switch",
      "case",
    },
    rust = {
      "impl_item",
      "struct",
      "enum",
    },
    markdown = {
      "section",
    },
    json = {
      "pair",
    },
    yaml = {
      "block_mapping_pair",
    },
  },
  zindex = 20,
  mode = "cursor",
  separator = nil,
})
