vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.treesitter.start()

    vim.lsp.config("pylsp", {
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
  end,
})

vim.b.runcmd = "uv run %"
