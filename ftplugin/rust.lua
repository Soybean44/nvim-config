vim.treesitter.start()

vim.keymap.del('n', '<leader>r')
vim.keymap.set('n', '<leader>r', ':Crun<CR>')
