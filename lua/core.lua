----------------------------------
-- The core functionality to my stupidly simple nvim config
-- Everything here is native vim and does not require any dependencies.
-- If you want more check out the modules that add extra functionality
----------------------------------

-- Options --

-- Numbers
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.cursorline = true
vim.o.cursorlineopt = "number"

-- Text Formating
vim.o.linebreak = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.autoindent = true
vim.o.scrolloff = 5

-- smart search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- completion
vim.o.clipboard = 'unnamedplus'
vim.o.winborder = 'rounded'
vim.opt.completeopt:append{"fuzzy", "noinsert", "menuone", "popup"}
vim.opt.complete:remove{"t"}
vim.o.termguicolors = true
vim.o.spelllang = "en_ca"
vim.o.spellsuggest = "best"

-- Misc

vim.opt.undofile = true  -- persistent undo history
vim.o.swapfile = false   -- removes annoying swap file
vim.o.hidden = true      -- swap buffers without having to save changes


-- Keybinds --

vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>x', ':update<CR> :source<CR>', { desc = "Source file" })
vim.keymap.set('n', '<leader>r', ':update<CR> :make<CR>', { desc = "Compile/Run file" })
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = "Delete buffer" })
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = "Next buffer" })
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', { desc = "Previous buffer" })
vim.keymap.set('n', '<leader>bl', ':buffers<CR>', { desc = "List buffers" })
vim.keymap.set('n', '<leader>nh', ':noh<CR>', { desc = "Clear Highlights" })
vim.keymap.set({ 'n', 'v', 'o', 'i', 'x' }, '<C-c>', '<Esc>')
vim.keymap.set({ 'n', 'v', 'o', 'i', 'x' }, '<C-h>', '<C-w>h')
vim.keymap.set({ 'n', 'v', 'o', 'i', 'x' }, '<C-j>', '<C-w>j')
vim.keymap.set({ 'n', 'v', 'o', 'i', 'x' }, '<C-k>', '<C-w>k')
vim.keymap.set({ 'n', 'v', 'o', 'i', 'x' }, '<C-l>', '<C-w>l')

-- LSP --

-- Settings
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = "Format buffer" })
vim.keymap.set('n', 'gD', vim.lsp.buf.definition, { desc = "Go to definition" })

-- Language Servers
-- Set this as desired, and imclude them in ../lsp/server_name.lua
vim.lsp.enable({ 'lua_ls', 'tinymist', 'clangd', 'pylsp' })




