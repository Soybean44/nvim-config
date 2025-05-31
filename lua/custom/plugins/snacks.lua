return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    lazygit = {
      configure = true
    },
  },
  config = function()
    local snacks = require('snacks')
    vim.keymap.set('n', '<leader>gs', snacks.lazygit.open, {silent = true, noremap = true})
  end
}
