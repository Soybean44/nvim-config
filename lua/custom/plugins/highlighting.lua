return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    config = function()
      vim.filetype.add { extension = { wgsl = "wgsl" } }
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.wgsl = {
        install_info = {
          url = "https://github.com/szebniok/tree-sitter-wgsl",
          files = { "src/parser.c" },
        },
      }
      require("nvim-treesitter.configs").setup {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = { "python", "lua", "vim", "vimdoc", "rust", "c", "cpp", "markdown", "latex", "wgsl" },
        highlight = {
          enable = true
        }
      }
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
