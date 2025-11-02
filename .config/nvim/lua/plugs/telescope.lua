local function config()
  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<c-p>', builtin.find_files, {})
  vim.keymap.set('n', '<c-R>', builtin.lsp_references, {})
  vim.keymap.set('n', '<c-F>', builtin.live_grep, {})
  vim.keymap.set('n', '<space>k', '<Cmd>Telescope keymaps<CR>', {})
  vim.keymap.set('n', '<space>j', '<Cmd>Telescope diagnostics<CR>', {})
end
return {
  'nvim-telescope/telescope.nvim',
  config = config,
  dependencies = {'nvim-lua/plenary.nvim'},
  version = '0.1.5',
}
