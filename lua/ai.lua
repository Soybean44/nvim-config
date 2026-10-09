--------------------------------------------
-- All AI related items in a modular file.
-- This file is completely optional
--------------------------------------------

vim.pack.add({
  { src = 'https://github.com/zbirenbaum/copilot.lua' },
  { src = 'https://github.com/CopilotC-Nvim/CopilotChat.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim'},
})

vim.g.copilot_nes_debounce = 500

require("copilot").setup({
suggestion = {
    enabled = true,
    auto_trigger = true,
    hide_during_completion = true,
    debounce = 15,
    trigger_on_accept = true,
    keymap = {
      accept = "<C-l>",
      accept_word = "<M-l>",
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
      toggle_auto_trigger = "<M-/>",
    },
  }
})

