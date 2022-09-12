require("urlview").setup({
  custom_searches = {
    jira = {
      capture = "OR%-%d+",
      format = "https://network.atix.de/browse/%s",
    },
  },
})
