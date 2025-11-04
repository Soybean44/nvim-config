-------------------------------------------
-- All 3rd party plugins in a modular file.
-- This file is completely optional
-------------------------------------------

vim.pack.add({
  { src = 'https://github.com/chomosuke/typst-preview.nvim' },
  { src = 'https://github.com/catppuccin/nvim' },
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/nvim-mini/mini.pick' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
})

-- Plugin Configuration -- 
require('mini.pick').setup({
  window = {
    config = function()
      local height = math.floor(0.618 * vim.o.lines)
      local width = math.floor(0.618 * vim.o.columns)
      return {
        anchor = 'NW',
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
      }
    end
  }
})
vim.keymap.set('n', '<leader>ff', ':Pick files<CR>')
vim.keymap.set('n', '<leader>fb', ':Pick buffers<CR>')
vim.keymap.set('n', '<leader>fh', ':Pick help<CR>')

require('oil').setup()
vim.keymap.set('n', '-', ':Oil<CR>', { desc = 'Open parent directory' })

require("nvim-treesitter.configs").setup({
  ensure_installed = { "typst", "lua", "python", "c", "cpp", "jinja", "html", "javascript", "css" },
  highlight = { enable = true }
})

require('catppuccin').setup({
  flavour = 'mocha',
  transparent_background = not vim.g.neovide,
})

vim.cmd('colorscheme catppuccin')


