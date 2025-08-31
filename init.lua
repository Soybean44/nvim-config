----------------------------------
-- A Stupidly Simple Neovim Config
----------------------------------

-- Options

vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.autoindent = true
vim.o.swapfile = false

vim.g.mapleader = " "

-- Keybinds

vim.keymap.set('n', '<leader>x', ':update<CR> :source<CR>')
vim.keymap.set({'n', 'v', 'o', 'i', 'x'}, '<C-c>', '<Esc>')
vim.keymap.set({'n', 'v', 'o', 'i', 'x'}, '<C-h>', '<C-w>h')
vim.keymap.set({'n', 'v', 'o', 'i', 'x'}, '<C-j>', '<C-w>j')
vim.keymap.set({'n', 'v', 'o', 'i', 'x'}, '<C-k>', '<C-w>k')
vim.keymap.set({'n', 'v', 'o', 'i', 'x'}, '<C-l>', '<C-w>l')

vim.pack.add({
	{src = "https://github.com/catppuccin/nvim"}, 
})

require("catppuccin").setup {
	flavour = "mocha",
	transparent_background = not vim.g.neovide,
	highlight_overrides = {
		mocha = function(mocha)
			return {
				Todo = { fg = mocha.yellow, bg = mocha.base },
				todo = { fg = mocha.yellow, bg = mocha.base },
			}
		end,
	},
}
vim.cmd("colorscheme catppuccin")

