vim.treesitter.start()

vim.keymap.del('n', '<leader>r')
vim.keymap.set('n', '<leader>r', ':!tmux next-window && tmux send-keys python Space % Enter<CR><CR>')

