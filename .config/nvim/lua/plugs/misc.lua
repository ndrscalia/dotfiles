local luapath = vim.fn.stdpath('config') .. '/lua'
return {
  {'ellisonleao/dotenv.nvim'},
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({})
    end
  },
  {'mg979/vim-visual-multi'},
  {'gcmt/wildfire.vim'},
  {'tpope/vim-surround'},
  {'nvim-tree/nvim-web-devicons'},
  {'kyazdani42/nvim-web-devicons', lazy = true},
  {'ap/vim-css-color'},
  {'nvim-lua/plenary.nvim'},
  {'tpope/vim-fugitive'},
  {'rbong/vim-flog'},
  {
    'tommason14/lammps.vim',
    lazy = nil,
  },
  {'tikhomirov/vim-glsl'},
  {'vito-c/jq.vim'},
  {'rhysd/vim-llvm'},
  {'kbenzie/vim-spirv'},
  {
    name = 'project-settings',
    dir = luapath .. '/project-settings',
    dependencies = {
      'https://github.com/LebJe/toml.lua',
      'rose-pine/neovim',
    }
  },
  -- lsp on attach
  {
    name = 'on-attach',
    dir = luapath .. '/on-attach'
  },
  {
    name = 'lsp-configs',
    dir = luapath .. '/lsp-configs',
    config = function()
      require('lsp-configs').setup()
    end,
    dependencies = {
      'on-attach',
      'neovim/nvim-lspconfig',
      'project-settings',
      'hrsh7th/nvim-cmp'
    }
  },
  -- latex
  {
    'lervag/vimtex',
    config = function()
      vim.cmd('let g:vimtex_view_method = "zathura"')
      vim.cmd('let g:vimtex_quickfix_mode = 0')
    end,
    ft = 'tex',
    lazy = nil,
  },
  {
    'KeitaNakamura/tex-conceal.vim',
    config = function()
      vim.cmd('let g:tex_conceal = "abdmg"')
      vim.cmd('highlight Conceal ctermbg = none')
      vim.cmd('let g:tex_flavor = "latex"')
    end,
    ft = 'tex',
    lazy = nil,
  },
  {
    'jbyuki/nabla.nvim',
    ft = 'tex',
    lazy = nil,
  },
  {
    'max397574/colortils.nvim',
    cmd = "Colortils",
    config = function()
      require("colortils").setup({})
    end,
    lazy = true,
  }
}
