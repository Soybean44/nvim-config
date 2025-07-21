return {
  "othree/html5.vim",
  "pangloss/vim-javascript",
  "HerringtonDarkholme/yats.vim",
  "evanleck/vim-svelte",
  {
    "alvan/vim-closetag",
    config = function()
      vim.g.closetag_filenames = { "*.html", "*.twig", "*.njk" }
    end,
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
      "neovim/nvim-lspconfig",       -- optional
    },
    opts = {}                        -- your configuration
  }
}
