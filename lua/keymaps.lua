-- define common options
local opts = {
  noremap = true, -- non-recursive
  silent = true,  -- do not show message
}

-----------------
-- Normal mode --
-----------------

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Hint: see `:h vim.map.set()`
-- Remap j and k to gj and gk
vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts)
vim.keymap.set("n", "gj", "j", opts)
vim.keymap.set("n", "gk", "k", opts)

-- Splits
vim.keymap.set("n", "<leader>v", "<Cmd>vsplit<CR>", opts)
vim.keymap.set("n", "<leader>h", "<Cmd>split<CR>", opts)
vim.keymap.set("n", "<leader>h", "<Cmd>split<CR>", opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set("n", "<M-k>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<M-j>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<M-l>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<M-h>", ":vertical resize +2<CR>", opts)

vim.keymap.set("n", "<M-up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<M-down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<M-right>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<M-left>", ":vertical resize +2<CR>", opts)

-- open config
vim.keymap.set('n', '<leader>cc', function()
  -- Change to the Neovim config directory
  vim.cmd('cd ~/.config/nvim')
  -- Open the init.lua file
  vim.cmd('edit init.lua')
end, { desc = "Change to Neovim config and open init.lua" })

-- kill buffer
vim.keymap.set("n", "<leader>bd", ":bdelete!<CR>", opts)

-- Yazi
vim.keymap.set("n", "-", "<Cmd>Yazi<CR>", opts)

-- Source file
vim.keymap.set("n", "<leader>x", ":w<CR>:source %<CR>", opts)

-----------------
-- Insert mode --
-----------------

vim.keymap.set("i", "<C-c>", "<Esc>", opts)
vim.keymap.set("i", "<C-v>", "<C-o>P", opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-----------------
-- Terminal mode --
-----------------
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)
