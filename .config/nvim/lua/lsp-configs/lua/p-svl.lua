local on_attach = require('on-attach')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')['svls'].setup {
  capabilities = capabilities,
  on_attach = on_attach
}
