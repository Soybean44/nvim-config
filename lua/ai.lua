vim.pack.add({
  { src = 'https://github.com/github/copilot.vim' },
  { src = 'https://github.com/CopilotC-Nvim/CopilotChat.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim'},
})
 
-- Keymaps
vim.keymap.set('i', '<M-l>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.keymap.set('i', '<M-L>', '<Plug>(copilot-accept-word)')
vim.keymap.set('n', '<leader>ac', ':CopilotChat<CR>', { noremap = true, silent = true })

-- Options
vim.g.copilot_no_tab_map = true

