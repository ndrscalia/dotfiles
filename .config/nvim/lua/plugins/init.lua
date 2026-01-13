return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-telescope/telescope-bibtex.nvim",
    ft = { "markdown", "tex" },
    config = function()
      require "configs.telescope-bibtex"
      require("telescope").load_extension("bibtex")
    end,
  },

  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        width = 80,          -- fixed width in columns
        options = {
          wrap = true,
          linebreak = true,
        },
      },
      on_open = function()
        vim.keymap.set("n", "j", "gj", { buffer = true })
        vim.keymap.set("n", "k", "gk", { buffer = true })
      end,
      on_close = function()
        vim.keymap.del("n", "j", { buffer = true })
        vim.keymap.del("n", "k", { buffer = true })
      end,
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      enabled = false,
    },
  },
  {
    "3rd/image.nvim",
    ft = { "markdown" },
    dependencies = {
      "luarocks.nvim",
    },
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = true,
          only_render_image_at_cursor = false,
        },
      },
    },
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
}
