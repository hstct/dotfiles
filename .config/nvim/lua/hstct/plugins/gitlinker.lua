require("gitlinker").setup({
  callbacks = {
    ["git.atix.de"] = require("gitlinker.hosts").get_gitlab_type_url,
  },
})
