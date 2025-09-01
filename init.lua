----------------------------------
-- A Stupidly Simple Neovim Config
----------------------------------

-- Options

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.wrap = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.autoindent = true
vim.o.swapfile = false
vim.o.clipboard = 'unnamedplus'
vim.o.winborder = 'rounded'
vim.o.completeopt = "fuzzy,menu"


vim.g.mapleader = ' '

-- Keybinds

vim.keymap.set('n', '<leader>x', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>r', ':make<CR>')
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>')
vim.keymap.set('n', '<leader>bn', ':bnext<CR>')
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>')
vim.keymap.set({ 'n', 'v', 'o', 'i', 'x' }, '<C-c>', '<Esc>')
vim.keymap.set({ 'n', 'v', 'o', 'i', 'x' }, '<C-h>', '<C-w>h')
vim.keymap.set({ 'n', 'v', 'o', 'i', 'x' }, '<C-j>', '<C-w>j')
vim.keymap.set({ 'n', 'v', 'o', 'i', 'x' }, '<C-k>', '<C-w>k')
vim.keymap.set({ 'n', 'v', 'o', 'i', 'x' }, '<C-l>', '<C-w>l')

-- LSP --

-- Settings
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

-- Language Servers
vim.lsp.enable({ 'lua_ls', 'tinymist', 'clangd' })

-- PLUGINS --

vim.pack.add({
	{ src = 'https://github.com/catppuccin/nvim' },
	{ src = 'https://github.com/stevearc/oil.nvim' },
	{ src = 'https://github.com/nvim-mini/mini.pick' },
	{ src = 'https://github.com/nvim-mini/mini.jump' },
	{ src = 'https://github.com/chomosuke/typst-preview.nvim' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
})

-- Plugin Configuration

require('mini.jump').setup()
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
