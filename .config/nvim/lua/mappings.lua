require "nvchad.mappings"

-- add yours here
vim.keymap.set("n", "<leader>fc", ":Telescope bibtex<CR>", { desc = "Find citation" })

vim.keymap.set("n", "<leader>z", ":ZenMode<CR>", { desc = "Toggle Zen Mode" })

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
