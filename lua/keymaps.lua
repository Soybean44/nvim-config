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
-- Insert mode --
-----------------

vim.keymap.set('i', 'jj', '<Esc>', opts)

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
