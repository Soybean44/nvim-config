return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  {
    "neovim/nvim-lspconfig",
    dependencies = "folke/neodev.nvim",
    config = function()
      require "custom.config.lsp"
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require "conform"

      conform.setup {
        formatters_by_ft = {
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          lua = { "stylua" },
          python = { "isort", "black" },
          cpp = { "astyle" },
          c = { "astyle" },
          rust = { "rustfmt" },
          zig = { "zig fmt" },
        },
        formatters = {
          astyle = {
            prepend_args = {"-A14", "-t"}
          },
        }
      }
      vim.keymap.set({ "n", "v" }, "<leader>mp", function()
        conform.format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        }
      end, { desc = "Format file or range (in visual mode)" })
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format { bufnr = args.buf }
        end,
      })
    end,
  },
  {
    'lervag/vimtex',
    config = function()
      vim.g.vimtex_view_method = 'zathura'
      vim.g.maplocalleader = ","
      vim.g.vimtex_view_general_viewer = 'okular'
      vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
      vim.g.vimtex_compiler_method = 'latexrun'
    end
  },
}
