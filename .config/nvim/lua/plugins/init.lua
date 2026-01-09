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
}
