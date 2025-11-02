local function config()
  local cmp = require('cmp')
  local luasnip = require('luasnip')
  local sources = {
    { name = 'nvim_lua', group_index = 1},
    { name = 'nvim_lsp', group_index = 1},
    { name = 'luasnip', group_index = 1},
    { name = 'nvim_lsp_signature_help', group_index = 1},
    { name = 'path', group_index = 2},
    { name = 'buffer', group_index = 2 }
  }
  
  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    -- window = {
    --   completion = cmp.config.window.bordered({ border = 'rounded' }),
    --   documentation = cmp.config.window.bordered({ border = 'rounded' }),
    -- },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.complete(),
      ['<C-c>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<Tab>'] = cmp.mapping(
        function(fallback)
          if (cmp.visible()) then
              cmp.select_next_item()
          elseif (luasnip.expand_or_jumpable()) then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }
      ),
      ['<S-Tab>'] = cmp.mapping(
        function(fallback)
          if (cmp.visible()) then
            cmp.select_prev_item()
          elseif (luasnip.jumpable(-1)) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }
      ),
    }),
    sources = sources
  })
   
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })
   
  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      {name = "path", group_index = 0},
      {name = 'cmdline', group_index = 1},
    } 
  })
end
return {
  'hrsh7th/nvim-cmp',
  version = nil,
  lazy = false,
  config = config,
  dependencies = {
    {'hrsh7th/cmp-nvim-lsp'},
    {'L3MON4D3/LuaSnip'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-path'},
    {'hrsh7th/cmp-cmdline'},
    {'hrsh7th/cmp-nvim-lsp-signature-help'},
    {'hrsh7th/cmp-nvim-lua'},
    {'saadparwaiz1/cmp_luasnip'},
  }
}
