return {
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    priority = 100,
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "dcampos/cmp-emmet-vim",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "folke/lazydev.nvim",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      require("custom.config.nvim-cmp")
    end
  },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("custom.config.luasnip")
    end,
  },
  {
    "iurimateus/luasnip-latex-snippets.nvim",
    -- vimtex isn't required if using treesitter
    requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
    config = function()
      require "custom.snippets.latex"
    end,
    ft = { "tex", "markdown" },
  },
}
