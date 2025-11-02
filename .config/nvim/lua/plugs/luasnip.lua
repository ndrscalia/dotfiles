local function config()
  local luasnip = require('luasnip')
  luasnip.config.set_config({
    region_check_events = 'InsertEnter',
    delete_check_events = 'InsertLeave'
  })
end
return {
  'L3MON4D3/LuaSnip',
  config = config
}
