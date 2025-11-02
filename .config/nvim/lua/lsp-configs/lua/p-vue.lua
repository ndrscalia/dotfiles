local lspconfig = require('lspconfig')
local npm_prefix = io.popen("npm config get prefix")
local tsdk = npm_prefix:read('*a')
tsdk = tsdk:gsub('[\n\r]', '')
npm_prefix:close()
local on_attach = require('on-attach')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.volar.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'vue' },
  init_options = {
    vue = { hybridMode = false, },
    typescript = { tsdk = tsdk .. "/lib/node_modules/typescript/lib"}
  },
}
