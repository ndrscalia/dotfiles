local function config()
  local on_attach = require('on-attach')
  require('lean').setup {
    abbreviations = { builtin = true },
    lsp = {
      on_attach = on_attach
    },
    lsp3 = {
      on_attach = on_attach
    },
    mappings = true
  } 
    
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
    
  require('lspconfig')['leanls'].setup {
    capabilities = capabilities,
    on_attach = on_attach
  } 
    
  require('lspconfig')['lean3ls'].setup {
    capabilities = capabilities,
    on_attach = on_attach
  } 
end
return {
  'Julian/lean.nvim',
  config = config,
  dependencies = {'nvim-lua/plenary.nvim'}
}
