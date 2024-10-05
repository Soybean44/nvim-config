return {
  {
    "hrsh7th/nvim-cmp",
    version = "1.x",
    dependencies = {
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      'dcampos/cmp-emmet-vim',
    },
  },
  "L3MON4D3/LuaSnip",
  {
    "iurimateus/luasnip-latex-snippets.nvim",
    -- vimtex isn't required if using treesitter
    requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
    config = function()
      require("custom.config.latex")
    end,
  },
  {
    "saadparwaiz1/cmp_luasnip",
    dependencies = { "nvim-cmp", "L3MON4D3/LuaSnip" },
  },
}
