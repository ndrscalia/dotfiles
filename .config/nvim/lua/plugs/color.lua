-- lua/plugs/color.lua
local function config()
  -- Nord options (set BEFORE loading the theme)
  vim.g.nord_contrast = false
  vim.g.nord_borders = false
  vim.g.nord_disable_background = false
  vim.g.nord_cursorline_transparent = false
  vim.g.nord_enable_sidebar_background = false
  vim.g.nord_italic = false
  vim.g.nord_uniform_diff_background = false
  vim.g.nord_bold = true

  -- Recreate your custom highlight groups using Nord colors
  -- Palette reference:
  --   polar night:  #2E3440, #3B4252, #434C5E, #4C566A
  --   aurora:       #BF616A (red), #D08770 (orange), #EBCB8B (yellow), etc.
  local function hl(name, opts) vim.api.nvim_set_hl(0, name, opts) end
  hl("ErrorLine", { bg = "#3B4252" }) -- darker bg for error lines
  hl("WarnLine", { bg = "#434C5E" })  -- warn lines
  hl("HintLine", { bg = "#2E3440" })  -- hint/info lines
  -- Underlines for diagnostics are already provided by default groups.

  -- Your diagnostics config (kept as-is)
  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = 'E',
        [vim.diagnostic.severity.WARN]  = 'W',
        [vim.diagnostic.severity.HINT]  = 'H',
      },
    },
    texthl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN]  = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.HINT]  = 'DiagnosticSignHint',
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorLine',
      [vim.diagnostic.severity.WARN]  = 'WarnLine',
      [vim.diagnostic.severity.HINT]  = 'HintLine',
    }
  })

  -- Apply the theme
  require("nord").set() -- same as :colorscheme nord
  -- or: vim.cmd('colorscheme nord')
end

return {
  "shaunsingh/nord.nvim",
  name = "nord",
  priority = 1000, -- ensure it loads early
  lazy = false,    -- load at startup so colors are ready
  config = config,
}
