local lspconfig = require('lspconfig')
local on_attach = require('on-attach')

local settings = require('project-settings')


local lsp_image = settings.cpp.lsp.image
local function docker_image(cmd, image)
  local cwd = vim.fn.getcwd();
  return { '/usr/bin/docker', 'container', 'run', '--interactive', '--rm', '--network=none', string.format(
    '--workdir=%s', cwd), string.format("--volume=%s:%s", cwd, cwd), image, cmd }
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
if lsp_image then
  lspconfig['clangd'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = docker_image('clangd', lsp_image)
  }
else
  lspconfig['clangd'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { "clangd" }
  }
end
