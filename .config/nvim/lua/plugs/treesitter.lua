local function config()
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      "c",
      "cpp",
      "lua",
      "glsl",
      "vim",
      "sql",
      "typescript",
      "bash",
      "rust",
      "make",
      "css",
      "html",
      "haskell",
      "verilog",
      "cmake",
      "python",
      "dockerfile"
    },
    auto_install = true,
    highlight = {
      enable = false,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>"
      }
    },
  })
end
return {
  'nvim-treesitter/nvim-treesitter',
  config = config
}
