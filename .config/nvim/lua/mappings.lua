require "nvchad.mappings"

-- add yours here
vim.keymap.set("n", "<leader>fc", ":Telescope bibtex<CR>", { desc = "Find citation" })

vim.keymap.set("n", "<leader>z", ":ZenMode<CR>", { desc = "Toggle Zen Mode" })

vim.keymap.set("n", "<leader>ti", function()
  local img = require("image")
  if img.is_enabled() then
    img.disable()
  else
    img.enable()
  end
end, { desc = "Toggle image.nvim" })

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- run everything between # %% markers (jupytext cell)
local function run_cell()
  local cur_line = vim.fn.line(".")
  local start_line = vim.fn.search("^# %%", "bncW")
  if start_line == 0 then start_line = 1 end
  vim.fn.cursor(start_line + 1, 1)
  local end_line = vim.fn.search("^# %%", "nW")
  vim.fn.cursor(cur_line, 1)
  start_line = start_line + 1
  if end_line == 0 then
    end_line = vim.fn.line("$")
  else
    end_line = end_line - 1
  end
  while end_line > start_line and vim.fn.getline(end_line):match("^%s*$") do
    end_line = end_line - 1
  end
  -- set visual marks directly, no visual mode needed
  vim.fn.setpos("'<", { 0, start_line, 1, 0 })
  vim.fn.setpos("'>", { 0, end_line, vim.fn.col({ end_line, "$" }), 0 })
  vim.cmd("MoltenEvaluateVisual")
end

-- molten keybindings
map("n", "<localleader>mi", ":MoltenInit<CR>", { desc = "Molten init kernel", silent = true })
map("n", "<localleader>e", "<cmd>MoltenEvaluateOperator<CR>", { desc = "Molten evaluate operator", silent = true })
map("n", "<localleader>rc", run_cell, { desc = "Molten run cell", silent = true })
map("n", "<localleader>rl", "<cmd>MoltenEvaluateLine<CR>", { desc = "Molten evaluate line", silent = true })
map("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Molten evaluate selection", silent = true })
map("n", "<localleader>os", ":noautocmd MoltenEnterOutput<CR>", { desc = "Molten open output", silent = true })
map("n", "<localleader>oh", ":MoltenHideOutput<CR>", { desc = "Molten hide output", silent = true })
map("n", "<localleader>md", ":MoltenDelete<CR>", { desc = "Molten delete cell", silent = true })
