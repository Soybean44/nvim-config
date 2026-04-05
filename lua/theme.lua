vim.pack.add({
  { src = 'https://github.com/catppuccin/nvim' },
})
require('catppuccin').setup({
  flavour = 'mocha',
  transparent_background = not vim.g.neovide,
})

vim.cmd('colorscheme catppuccin')

