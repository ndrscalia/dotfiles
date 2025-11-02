local lspconfig = require('lspconfig')
local on_attach = require('on-attach')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig['gopls'].setup {
  capabilities = capabilities,
  on_attach = on_attach
}
