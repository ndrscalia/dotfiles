vim.cmd([[au BufRead,BufNewFile *.jq setfiletype jq]])
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = require('on-attach')
require('lspconfig')['jqls'].setup {
  capabilities = capabilities,
  on_attach = on_attach
}
