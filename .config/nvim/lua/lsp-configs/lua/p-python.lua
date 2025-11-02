local on_attach = require('on-attach')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')['pyright'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { 'pyright-langserver', '--stdio' }
}
