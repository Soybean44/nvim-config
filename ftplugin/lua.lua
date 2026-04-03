vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function() vim.treesitter.start() end,
})

vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = { enable = false },
			diagnostics = {
				disable = { 'missing-fields' },
			}
		}
	}
})
