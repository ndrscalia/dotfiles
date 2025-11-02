local settings_path = io.popen('pwd'):read() .. '/settings.toml'

local default_settings = require('default-settings')

local function settings_merge(value, default)
  if value == nil then
    return default
  end
  for k, v in pairs(default) do
    if type(v) == 'table' then
      value[k] = settings_merge(value[k], v)
    elseif value[k] == nil then
      value[k] = default[k]
    end
  end
  return value
end

if vim.fn.filereadable(settings_path) == 0 then
  return default_settings
end

local keys_dir = vim.fn.expand('/$HOME/.cache/toml-nvim-settings/')
os.execute('mkdir -p ' .. keys_dir .. ' > /dev/null')

local keys_path = keys_dir .. '/keys'
os.execute("touch " .. keys_path)
local check = false
local cmd = string.format("sha256sum -c %s %s | grep 'OK'$ > /dev/null", settings_path, keys_path)
while not check do
  check = os.execute(cmd) == 0
  if not check then
    vim.notify("these settings are not trusted. cancel [c] or trust [t]?", vim.log.levels.WARN)
    local action = vim.fn.input('')
    if action == 'c' then
      return default_settings
    end
    if action == 't' then
      os.execute("sha256sum " .. settings_path .. " >> " .. keys_path)
    end
  end
end

local toml = require('toml')
local success, settings = pcall(toml.decodeFromFile, settings_path)
if not success then
  vim.notify("unable to load settings.toml, possible parsing error.", vim.log.levels.ERROR)
  return default_settings
end

return settings_merge(settings, default_settings)
