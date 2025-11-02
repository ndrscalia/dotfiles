local function config()

  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
   
  require("nvim-tree").setup({
    sort_by = "case_sensitive",
    actions = {
      open_file = { quit_on_open = true }
    },
    update_focused_file = {
      enable = true,
      update_cwd = true
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = false,
    },
    log = {
      enable = true,
      types = { diagnostics = true }
    },
    diagnostics = {
      enable = true,
      show_on_dirs = false,
      debounce_delay = 50,
      icons = {
        hint = 'H',
        info = 'I',
        warning = 'W',
        error = 'E'
      }
    }
  })
  local termux = os.getenv('TERMUX_VERSION')
  local toggle = termux and '<F10>' or '<c-e>'
  vim.keymap.set('n', toggle, '<cmd>NvimTreeToggle<cr>')

  vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "bg" })
  vim.cmd([[highlight NonText guifg=bg]])
end
return {
  'nvim-tree/nvim-tree.lua',
  config = config,
  dependencies = {'nvim-tree/nvim-web-devicons'}
}
