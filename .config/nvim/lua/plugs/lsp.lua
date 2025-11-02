local function config()
  local opts = { noremap = true, silent = true }
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', 'qf', vim.lsp.buf.code_action, opts)
   
  vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = false,
      virtual_text = true,
      signs = true,
      update_in_insert = true
  })
end

return {
  'neovim/nvim-lspconfig',
  config = config,
}
