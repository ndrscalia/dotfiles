-- Spell checking (default English)
vim.opt_local.spell = true
vim.opt_local.spelllang = "en"

-- Word count
vim.keymap.set("n", "<leader>wc", function()
  local wc = vim.fn.wordcount()
  print("Words: " .. wc.words .. " | Chars: " .. wc.chars)
end, { buffer = true, desc = "Word count" })

-- renderer-markdown quick toggle
vim.keymap.set("n", "<leader>mr", ":RenderMarkdown toggle<CR>", { buffer = true, desc = "Toggle render markdown" })
