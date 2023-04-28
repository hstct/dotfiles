local lsp = require("lspconfig")
local U = require("hstct.plugins.lsp.utils")

---Common perf related flags for all the LSP servers
local flags = {
  allow_incremental_sync = true,
  debounce_text_changes = 200,
}

---Common capabilities including lsp snippets and autocompletion
local capabilities = require("cmp_nvim_lsp").default_capabilities()

---Common `on_attach` function for LSP servers
---@param client table
---@param buf integer
local function on_attach(client, buf)
  U.disable_formatting(client)
  U.mappings(buf)
end

-- Disable LSP logging
vim.lsp.set_log_level(vim.lsp.log_levels.OFF)

-- Configuring native diagnostics
vim.diagnostic.config({
  virtual_text = {
    source = "always",
  },
  float = {
    source = "always",
  },
})

-- lua
lsp.lua_ls.setup({
  flags = flags,
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      completion = {
        enable = true,
        showWord = "Disable",
      },
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = { os.getenv("VIMRUNTIME") },
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

-- rust
lsp.rust_analyzer.setup({
  flags = flags,
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      checkOnSave = {
        allFeatures = true,
        command = "clippy",
      },
      procMacro = {
        ignored = {
          ["async-trait"] = { "async_trait" },
          ["napi-derive"] = { "napi" },
          ["async-recursion"] = { "async_recursion" },
        },
      },
    },
  },
})

---List of the LSP servers that don't need special configuration
local servers = {
  "zls", -- Zig
  "gopls", -- Golang
  "tsserver", -- Typescript
  "pyright", -- Python
  "html", -- HTML
  "cssls", -- CSS
  "jsonls", -- JSON
  "yamlls", -- YAML
  "zk",
  "solargraph",
  -- 'terraformls', -- Terraform
}

local conf = {
  flags = flags,
  capabilities = capabilities,
  on_attach = on_attach,
}

for _, server in ipairs(servers) do
  lsp[server].setup(conf)
end
