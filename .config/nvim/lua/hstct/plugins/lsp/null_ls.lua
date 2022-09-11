local nls = require("null-ls")
local U = require("hstct.plugins.lsp.utils")

local fmt = nls.builtins.formatting
local dgn = nls.builtins.diagnostics

nls.setup({
  sources = {
    fmt.trim_whitespace.with({
      filetypes = { "text", "zsh", "toml", "make", "conf", "tmux" },
    }),
    -- fmt.prettierd.with({
    --   condition = function(utils)
    --     return not utils.root_has_file({ ".eslintrc", ".eslintrc.js" }) and vim.bo.filetype ~= "markdown"
    --   end,
    --   prefer_local = "node_modules/.bin",
    -- }),
    -- fmt.eslint_d.with({
    --   condition = function(utils)
    --     return utils.root_has_file({ ".eslintrc", ".eslintrc.js" })
    --   end,
    --   prefer_local = "node_modules/.bin",
    -- }),
    fmt.rustfmt,
    fmt.stylua,
    fmt.terraform_fmt,
    fmt.gofmt,
    fmt.goimports,
    fmt.shfmt.with({
      extra_args = { "-i", "2", "-ci" },
    }),
    -- fmt.black.with({
    --   extra_args = { "--fast" },
    --   filetypes = { "python" },
    -- }),
    -- fmt.isort.with({
    --   extra_args = { "--profile", "black" },
    --   filetypes = { "python" },
    -- }),

    dgn.ansiblelint.with({
      condition = function(utils)
        return utils.root_has_file("roles") and utils.root_has_file("inventories")
      end,
    }),
    dgn.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ ".eslintrc", ".eslintrc.js" })
      end,
      prefer_local = "node_modules/.bin",
    }),
    dgn.shellcheck,
    dgn.luacheck.with({
      extra_args = { "--globals", "vim", "--std", "luajit" },
    }),
    dgn.golangci_lint.with({
      condition = function(utils)
        return utils.root_has_file(".golangci.yml")
      end,
    }),
  },
  on_attach = function(client, bufnr)
    U.fmt_on_save(client)
    U.mappings(bufnr)
  end,
})
