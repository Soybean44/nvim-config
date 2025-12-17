--------------------------------------------
-- All AI related items in a modular file.
-- This file is completely optional
--------------------------------------------

vim.pack.add({
  { src = 'https://github.com/github/copilot.vim' },
  { src = 'https://github.com/CopilotC-Nvim/CopilotChat.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim'},
})
 
-- Keymaps
vim.keymap.set('i', '<C-l>', 'copilot#Accept("\\<CR>")', {
          expr = true,
          replace_keycodes = false
        })
vim.keymap.set('i', '<M-C-l>', '<Plug>(copilot-accept-word)')
vim.keymap.set('n', '<leader>ac', ':CopilotChatToggle<CR>', { noremap = true, silent = true })

-- Options
vim.g.copilot_no_tab_map = true

