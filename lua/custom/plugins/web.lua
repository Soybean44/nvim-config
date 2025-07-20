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
}
