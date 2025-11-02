local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local on_attach = require('on-attach')
require('lspconfig').cssls.setup {
  capabilities = capabilities,
  on_attach = on_attach
}
