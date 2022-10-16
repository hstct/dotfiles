local present, _ = pcall(require, "packer")
if not present then
  local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
  print("Cloning packer..")
  vim.fn.delete(packer_path, "rf")
  vim.fn.system({
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    "--depth",
    "20",
    packer_path,
  })
  vim.cmd("packadd packer.nvim")
  local local_present, packer = pcall(require, "packer")
  if local_present then
    print("Packer cloned successfully.")
  else
    error("Couldn't clone packer!\nPacker path: " .. packer_path .. "\n" .. packer)
  end
end

-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("PACKER", { clear = true }),
  pattern = "plugins.lua",
  command = "source <afile> | PackerCompile",
})

return require("packer").startup({
  function(use)
    -- Package manager --
    use({ "wbthomason/packer.nvim" })

    -- Required plugins --
    use("nvim-lua/plenary.nvim")
    use("lewis6991/impatient.nvim")
    use("nathom/filetype.nvim")

    -- Theme, icons, statusbar, bufferbar --
    use({
      "kyazdani42/nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup()
      end,
    })

    use({
      "sainnhe/gruvbox-material",
      config = function()
        require("hstct.plugins.theme")
      end,
    })

    use({
      {
        "nvim-lualine/lualine.nvim",
        after = "gruvbox-material",
        event = "BufEnter",
        config = function()
          require("hstct.plugins.lualine")
        end,
      },
      {
        "j-hui/fidget.nvim",
        after = "lualine.nvim",
        config = function()
          require("fidget").setup()
        end,
      },
    })

    -- treesitter --
    use({
      {
        "nvim-treesitter/nvim-treesitter",
        event = "CursorHold",
        run = ":TSUpdate",
        config = function()
          require("hstct.plugins.nvim_treesitter")
        end,
      },
      { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
      { "nvim-treesitter/nvim-treesitter-refactor", after = "nvim-treesitter" },
      {
        "nvim-treesitter/nvim-treesitter-context",
        after = "nvim-treesitter",
        config = function()
          require("hstct.plugins.nvim_treesitter_context")
        end,
      },
      { "windwp/nvim-ts-autotag", after = "nvim-treesitter" },
      { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },
    })

    -- editor ui niceties --
    use({
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      config = function()
        require("hstct.plugins.indent_blankline")
      end,
    })

    use({
      "norcalli/nvim-colorizer.lua",
      event = "CursorHold",
      config = function()
        require("colorizer").setup()
      end,
    })

    use({
      "lewis6991/gitsigns.nvim",
      event = "BufRead",
      config = function()
        require("hstct.plugins.gitsigns")
      end,
    })

    use({
      "TimUntersberger/neogit",
      cmd = "Neogit",
      config = function()
        require("hstct.plugins.neogit")
      end,
    })

    use({
      "sindrets/diffview.nvim",
      config = function()
        require("hstct.plugins.diffview")
      end,
    })

    use({
      "ruifm/gitlinker.nvim",
      config = function()
        require("hstct.plugins.gitlinker")
      end,
    })

    -- navigation and fuzzy search --
    use({
      "kyazdani42/nvim-tree.lua",
      event = "CursorHold",
      config = function()
        require("hstct.plugins.nvim_tree")
      end,
    })

    use({
      {
        "nvim-telescope/telescope.nvim",
        event = "CursorHold",
        config = function()
          require("hstct.plugins.telescope")
        end,
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        after = "telescope.nvim",
        run = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      {
        "nvim-telescope/telescope-symbols.nvim",
        after = "telescope.nvim",
      },
    })

    use({
      "numToStr/Navigator.nvim",
      event = "CursorHold",
      config = function()
        require("hstct.plugins.navigator")
      end,
    })

    use({
      "phaazon/hop.nvim",
      event = "BufRead",
      config = function()
        require("hstct.plugins.hop")
      end,
    })

    use({
      "ThePrimeagen/harpoon",
      config = function()
        require("hstct.plugins.harpoon")
      end,
    })

    -- editing --
    use({
      "numToStr/Comment.nvim",
      event = "BufRead",
      config = function()
        require("Comment").setup()
      end,
    })

    use({
      "abecodes/tabout.nvim",
      wants = "nvim-treesitter",
      after = "nvim-cmp",
      config = function()
        require("hstct.plugins.tabout")
      end,
    })

    use({
      "kylechui/nvim-surround",
      tag = "*",
      config = function()
        require("hstct.plugins.nvim_surround")
      end,
    })

    -- terminal --
    use({
      "numToStr/FTerm.nvim",
      event = "CursorHold",
      config = function()
        require("hstct.plugins.fterm")
      end,
    })

    -- lsp, completions and snippets --
    use({
      "neovim/nvim-lspconfig",
      event = "BufRead",
      config = function()
        require("hstct.plugins.lsp.servers")
      end,
      requires = {
        {
          "hrsh7th/cmp-nvim-lsp",
        },
      },
    })

    use({
      "jose-elias-alvarez/null-ls.nvim",
      event = "BufRead",
      config = function()
        require("hstct.plugins.lsp.null_ls")
      end,
    })

    use({
      {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        config = function()
          require("hstct.plugins.lsp.nvim_cmp")
        end,
        requires = {
          {
            "L3MON4D3/LuaSnip",
            event = "InsertEnter",
            config = function()
              require("hstct.plugins.lsp.luasnip")
            end,
            requires = {
              "rafamadriz/friendly-snippets",
              event = "CursorHold",
            },
          },
        },
      },
      { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
      { "hrsh7th/cmp-path", after = "nvim-cmp" },
      { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
    })

    use({
      "windwp/nvim-autopairs",
      event = "InsertCharPre",
      after = "nvim-cmp",
      config = function()
        require("hstct.plugins.nvim_autopairs")
      end,
    })

    -- misc
    use({
      "mickael-menu/zk-nvim",
      config = function()
        require("hstct.plugins.zk")
      end,
    })

    use({
      "axieax/urlview.nvim",
      config = function()
        require("hstct.plugins.urlview")
      end,
    })

    use({
      "stevearc/dressing.nvim",
      config = function()
        require("hstct.plugins.dressing")
      end,
    })
    use({ "mboughaba/i3config.vim" })
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
  },
})
