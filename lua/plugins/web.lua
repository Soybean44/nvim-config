return {
  "othree/html5.vim",
  "pangloss/vim-javascript",
  "HerringtonDarkholme/yats.vim",
  "evanleck/vim-svelte",
  "mattn/emmet-vim",
  {
    "alvan/vim-closetag",
    config = function()
      -- <C-y> , to use emmet
      vim.g.closetag_filenames = "*.html,*.xhtml,*.phtml,*.svelte"
    end,
  },
}
