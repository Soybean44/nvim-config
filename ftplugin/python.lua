vim.treesitter.start()
vim.b.runcmd = "uv run %"

vim.lsp.config("pylsp",  {
  settings = {
    pylsp = {
      plugins = {
        ruff = {
          enabled = true,
          formatEnabled = true
        },
      }
    }
  }
})

