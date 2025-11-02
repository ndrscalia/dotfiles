vim.cmd('let g:tex_conceal = "abdmg"')
vim.cmd('highlight Conceal ctermbg = none')
vim.cmd('let g:tex_flavor = "latex"')
vim.cmd('let g:vimtex_view_method = "zathura"')
vim.cmd('let g:vimtex_quickfix_mode = 0')

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = require('on-attach')
require('lspconfig')['texlab'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
