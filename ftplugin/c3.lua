vim.api.nvim_create_autocmd("FileType", {
  pattern = "c3",
  callback = function() vim.treesitter.start() end,
})
vim.b.runcmd = "c3c run"
