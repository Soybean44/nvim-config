require("nvim-treesitter.config").setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "python", "lua", "vim", "vimdoc", "rust", "c", "cpp", "markdown", "zig", "latex", "c3", "supercollider", "typst" },
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  fold = {
    enable = true,
  },
}
vim.treesitter.language.register('python', 'sage')
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevelstart = 99 -- do not close folds when a buffer is opened
