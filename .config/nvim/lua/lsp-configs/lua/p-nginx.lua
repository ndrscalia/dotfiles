local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = require('on-attach')
require('lspconfig')['nginx_language_server'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
