vim.treesitter.start()

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
