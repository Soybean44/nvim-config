return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
      require("custom.config.treesitter")
    end,
  },
  {
    "tpope/vim-markdown",
    ft = "markdown",
    config = function()
      vim.g.markdown_fenced_languages = { "html", "python", "bash=sh" }
    end,
  },
}
