vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = function()
    vim.treesitter.start()
  end,
})
vim.b.runcmd = "make run"

