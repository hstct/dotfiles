-- Treesitter folds
-- vim.o.foldmethod = 'expr'
-- vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
-- vim.o.foldlevelstart = 99

require("nvim-treesitter.configs").setup({
  -- nvim-treesitter/nvim-treesitter (self config)
  auto_install = true,
  ensure_installed = {
    "bash",
    "bibtex",
    "c",
    "cmake",
    "comment",
    "cpp",
    "css",
    "cuda",
    "devicetree",
    "dockerfile",
    "go",
    "gomod",
    "gowork",
    "graphql",
    "html",
    "http",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "json5",
    "jsonc",
    "julia",
    "kotlin",
    "latex",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "ninja",
    "nix",
    "perl",
    "python",
    "query",
    "r",
    "rasi",
    "regex",
    "rst",
    "ruby",
    "rust",
    "scala",
    "scss",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "yaml",
  },
  -- ensure_installed = "all",
  -- ignore_installed = { "phpdoc" },
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this options may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = { "markdown" },
  },
  indent = {
    enable = true,
    disable = { "python" },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gs",
      -- NOTE: These are visual mode mappings
      node_incremental = "gs",
      node_decremental = "gS",
      scope_incremental = "<leader>gc",
    },
  },
  -- nvim-treesitter/nvim-treesitter-textobjects
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["uc"] = "@comment.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
        ["<leader>f"] = "@function.outer",
        ["<leader>e"] = "@element",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
        ["<leader>F"] = "@parameter.outer",
        ["<leader>E"] = "@element",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
  -- windwp/nvim-ts-autotag
  autotag = {
    enable = true,
  },
  -- nvim-treesitter/playground
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,
    persist_queries = false,
  },
  -- nvim-treesitter/nvim-treesitter-refactor
  refactor = {
    highlight_definitions = { enable = true },
  },
})
