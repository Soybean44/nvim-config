vim.treesitter.start()

vim.keymap.del('n', '<leader>r')
vim.keymap.set('n', '<leader>r', ':make | !tmux next-window && tmux send-keys make Space run Space % Enter<CR><CR>')
