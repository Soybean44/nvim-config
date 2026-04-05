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
vim.lsp.enable({ 'lua_ls', 'tinymist', 'clangd', 'pylsp', 'zls', 'c3_lsp' })

-- Autotrigger
-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('my.lsp', {}),
--   callback = function(ev)
--     local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
--     -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
--     if client:supports_method('textDocument/completion') then
--       vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--     end
--   end,
-- })
