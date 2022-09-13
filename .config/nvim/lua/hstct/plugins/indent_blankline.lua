require("indent_blankline").setup({
  show_first_indent_level = false,
  filetype_exclude = {
    "help",
    "packer",
    "FTerm",
    "NeogitStatus",
    "NeogitCommitView",
    "NeogitLogView",
    "NeogitPopup",
    "NeogitCommitMessage",
    "man",
    "TelescopePrompt",
    "DiffviewFiles",
    "DiffviewFileHistory",
    "fugitive",
  },
  buftype_exclude = { "terminal", "nofile" },
})
