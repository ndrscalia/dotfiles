local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = require('on-attach')
require('lspconfig')['ts_ls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = {'npx', 'typescript-language-server', '--stdio'}
}
