vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- enable python provider before NvChad disables it (needed for molten.nvim)
vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")

-- detect Godot project (walk up one level to catch subdirs like `scripts/`)
local cwd = vim.fn.getcwd()
local godot_root = nil
for _, rel in ipairs({ "", "/.." }) do
  if vim.uv.fs_stat(cwd .. rel .. "/project.godot") then
    godot_root = vim.fn.fnamemodify(cwd .. rel, ":p")
    break
  end
end
vim.g.is_godot_project = godot_root ~= nil
if godot_root and not vim.uv.fs_stat(godot_root .. "server.pipe") then
  vim.fn.serverstart(godot_root .. "server.pipe")
end

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)
