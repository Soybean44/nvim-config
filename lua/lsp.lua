----------------------------------------------
-- All LSP related settings in a modular file.
-- This file is completely optional
----------------------------------------------

vim.pack.add({
  { src = 'https://github.com/neovim/nvim-lspconfig' }
})


-- Settings
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = "Format buffer" })
vim.keymap.set('n', 'gD', vim.lsp.buf.definition, { desc = "Go to definition" })

-- Language Servers
-- Set this as desired, and imclude them in ../lsp/server_name.lua
vim.lsp.enable({ 'lua_ls', 'tinymist', 'clangd', 'pylsp', 'zls' })
