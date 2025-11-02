local function config()
  local function sha256of(filename)
    local handle = io.popen("sha256sum " .. filename)
    if handle == nil then
      return nil
    end
    local result = handle:read("*a")
    handle:close()
    local sha256 = result:match("^%s*(%x+)")
    return sha256
  end

  local function installed(download_dir)
    os.execute(
      "curl -Lo " ..
      download_dir ..
      "jdtls_latest 'https://www.eclipse.org/downloads/download.php?file=/jdtls/snapshots/latest.txt'")
    local file = io.open(download_dir .. 'jdtls_latest', 'r')
    if not file then
      return false
    end
    local version = file:read('*a')
    version = version:gsub("%s+", "")
    file:close()

    os.execute(
      "curl -Lo " ..
      download_dir .. "jdtls_sha256 'https://download.eclipse.org/jdtls/snapshots/" .. version .. ".sha256'")
    local sha = io.open(download_dir .. 'jdtls_sha256')
    if sha == nil then
      return false
    end
    local web_hash = sha:read("*l")
    web_hash = web_hash:gsub("%s+", "")
    local hash = sha256of(download_dir .. 'jdtls.tar.gz')
    sha:close()
    if hash == web_hash then
      return true
    end
    return false
  end

  local function install(download_dir, install_dir)
    download_dir = vim.fn.expand(download_dir .. '/')
    install_dir = vim.fn.expand(install_dir .. '/')
    local cmd = install_dir .. 'bin/jdtls';
    if installed(download_dir) then
      return cmd
    end
    local jdtls = 'jdtls.tar.gz'
    os.execute('cd ' .. download_dir .. '; curl -Lo ' ..
      jdtls ..
      " 'https://www.eclipse.org/downloads/download.php?file=/jdtls/snapshots/jdt-language-server-latest.tar.gz'")

    os.execute('mkdir -p ' .. install_dir)
    os.execute('tar -xzf ' .. download_dir .. jdtls .. ' -C ' .. install_dir)
    return cmd
  end

  local on_attach = require('on-attach')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local cmd = install('$HOME/.cache/', '$HOME/.local/share/jdtls/');
  require('lspconfig')['jdtls'].setup({
    cmd = { cmd },
    capabilities = capabilities,
    on_attach = on_attach
  })
  local jdt_config = {
    cmd = { cmd },
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
    capabilities = capabilities,
    on_attach = on_attach,
  }
  require('jdtls').start_or_attach(jdt_config)
end

return {
  'mfussenegger/nvim-jdtls',
  config = config,
  ft = 'java',
  dependencies = {
    'on-attach',
    'hrsh7th/nvim-cmp',
  }
}
