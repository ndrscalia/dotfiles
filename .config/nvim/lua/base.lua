local opt = vim.opt

opt.number = true
opt.tabstop = 2
opt.softtabstop = 0
opt.expandtab = true
opt.shiftwidth = 2
opt.smarttab = true
opt.relativenumber = true

opt.termguicolors = true
opt.cursorline = true
opt.swapfile = false
opt.breakindent = true
opt.lbr = true

opt.conceallevel = 1

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({
      highgroup = 'IncSearch',
      timeout = 300
    })
  end
})

opt.fillchars:append({ eob = " " })
