return {
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
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
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "custom.config.lsp"
    end,
  },
  {
    "stevearc/conform.nvim",
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
          ocaml = { "dune fmt" },
        },
        formatters = {
          astyle = {
            prepend_args = { "-A14", "-t" },
          },
        },
      }
      vim.keymap.set({ "n", "v" }, "<leader>mp", function()
        conform.format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        }
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },
  {
    "lervag/vimtex",
    config = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_view_forward_search_on_start = false
      vim.g.maplocalleader = ","
      vim.g.vimtex_view_general_viewer = "okular"
      vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_auto_compile = 1
      vim.g.vimtex_latexmk = {
        backend = 'latexmk',
        options = {
          '-pdf',
          '-pdflatex=lualatex',
        },
      }
    end,
    ft = { "tex", "markdown" },
  },
  {
    'kaarmu/typst.vim',
    ft = 'typst',
    config = function()
      vim.g.typst_syntax_highlight = 0
      vim.g.typst_pdf_viewer = 'zathura'
      vim.keymap.set('n', "<localleader>tt", ":TypstWatch<CR>", { noremap = true, silent = true })
    end
  },
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',
    opts = {}, -- lazy.nvim will implicitly calls `setup {}`
    vim.keymap.set('n', "<localleader>tp", ":TypstPreviewToggle<CR>", { noremap = true, silent = true })
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      require("custom.config.jdtls")
    end,
  },
  {
    "R-nvim/R.nvim",
    ft = { "r", "rmd", "quarto" },
    config = function()
      local opts = {
        external_term = "tmux split-window -hdl 80",
        pipe_version = "magrittr",
        view_df = {
          open_app = "vdata"
        }
      }
      require("r").setup(opts)

      vim.keymap.set("n", "<LocalLeader>qp", "<Plug>RQuartoPreview", {})
      vim.keymap.set("n", "<LocalLeader>qr", "<Plug>RQuartoRender", {})
    end
  },
}
