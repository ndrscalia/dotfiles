-- spell checking (default English)
vim.opt_local.spell = true
vim.opt_local.spelllang = "en"

-- word count
vim.keymap.set("n", "<leader>wc", function()
  local wc = vim.fn.wordcount()
  print("Words: " .. wc.words .. " | Chars: " .. wc.chars)
end, { buffer = true, desc = "Word count" })

-- renderer-markdown quick toggle
vim.keymap.set("n", "<leader>mr", ":RenderMarkdown toggle<CR>", { buffer = true, desc = "Toggle render markdown" })

-- browse md sections quick toggle
vim.keymap.set("n", "<leader>ms", ":Telescope lsp_document_symbols<CR>", { buffer = true, desc = "Markdown sections" })
