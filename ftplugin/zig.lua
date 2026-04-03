vim.api.nvim_create_autocmd("FileType", {
  pattern = "typst",
  callback = function() vim.treesitter.start() end,
})
vim.b.runcmd = "zig build run"
