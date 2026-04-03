vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  callback = function() vim.treesitter.start() end,
})
