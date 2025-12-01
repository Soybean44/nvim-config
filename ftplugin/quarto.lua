vim.keymap.del('n', '<leader>r')
vim.keymap.set('n', '<leader>r', '!tmux next-window && tmux send-keys quarto Space preview Space % Enter<CR><CR>')
