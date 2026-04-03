vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function() vim.treesitter.start() end,
})

vim.keymap.del('n', '<leader>r')
vim.keymap.set('n', '<leader>r', ':Crun<CR>')
