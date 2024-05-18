return {
  "othree/html5.vim",
  "pangloss/vim-javascript",
  "HerringtonDarkholme/yats.vim",
  "evanleck/vim-svelte",
  {
    "mattn/emmet-vim",
    config = function ()
      vim.g.user_emmet_leader_key='<C-Z>'
    end
  },
  {
    "alvan/vim-closetag",
    config = function()
      -- <C-y> , to use emmet
      vim.g.closetag_filenames = "*.html"
    end,
  },
}
