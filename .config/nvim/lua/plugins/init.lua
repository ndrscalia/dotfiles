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
      max_width = 100,
      max_height = 40,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    lazy = false,
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_auto_open_output = false
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_output_win_max_height = 80
      vim.g.molten_virt_text_max_lines = 80
    end,
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  {
    "stevearc/aerial.nvim",
    ft = { "markdown" },
    opts = {},
  },
  {
    "GCBallesteros/jupytext.nvim",
    lazy = false,
    config = true,
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = true,
  },
  {
    "jpalardy/vim-slime",
    lazy = false,
    config = function()
        vim.g.slime_target = "tmux"
        vim.g.slime_default_config = {
            socket_name = "default",
            target_pane = "{last}",
        }
        vim.g.slime_dont_ask_default = 1
        vim.g.slime_no_mappings = 1

        vim.keymap.set("n", "<leader>ss", "<Plug>SlimeParagraphSend", { desc = "Send paragraph" })
        vim.keymap.set("x", "<leader>ss", "<Plug>SlimeRegionSend", { desc = "Send selection" })
        vim.keymap.set("n", "<leader>sl", "<Plug>SlimeLineSend", { desc = "Send line" })
    end,
  },
}
