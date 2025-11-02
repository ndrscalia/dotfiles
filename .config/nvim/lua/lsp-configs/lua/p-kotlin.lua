local on_attach = require('on-attach')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local HOME = os.getenv("HOME")
local ANDROID_SDK_ROOT = os.getenv("ANDROID_SDK_ROOT")
local ANDROID_HOME = os.getenv("ANDROID_HOME")

require('lspconfig')['kotlin_language_server'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd_env = { ANDROID_SDK_ROOT = ANDROID_SDK_ROOT, ANDROID_HOME = ANDROID_HOME, JAVA_HOME = "/usr/lib/jvm/java-17-openjdk" },
  cmd = { HOME .. '/bin/kotlin-language-server/server/build/install/server/bin/kotlin-language-server' }
}
