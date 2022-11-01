require("urlview").setup()

local search = require("urlview.search")
local search_helpers = require("urlview.search.helpers")

search["jira"] = search_helpers.generate_custom_search({
  capture = "OR%-%d+",
  format = "https://network.atix.de/browse/%s",
})
