local default_ssh = {
  url = nil,
  host = nil,
  user = nil,
  port = nil
}
local default_lsp = {
  ssh = default_ssh,
  image = nil,
}
local default_dap = default_lsp

local default_settings = {
  cpp = { lsp = default_lsp, dap = default_dap, gdb = nil, main = nil },
  java = { lsp = default_lsp, dap = default_dap, main = nil },
  copilot = { enable = nil, no_load = nil, append_filetypes = nil },
  env = nil
}

return default_settings
