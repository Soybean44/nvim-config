-- define common options
local opts = {
  noremap = true, -- non-recursive
  silent = true,  -- do not show message
}

-----------------
-- Normal mode --
-----------------

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Remap j and k to gj and gk
vim.keymap.set('n', 'j', 'gj', opts)
vim.keymap.set('n', 'k', 'gk', opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set('n', '<M-k>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<M-j>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<M-l>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<M-h>', ':vertical resize +2<CR>', opts)


-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-----------------
-- Terminal mode --
-----------------
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', opts)
