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
          ocaml = { "dune fmt" },
        },
        formatters = {
          astyle = {
            prepend_args = { "-A14", "-t" },
          },
        },
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_format = "fallback" }
        end,
      }
      vim.keymap.set({ "n", "v" }, "<leader>mp", function()
        conform.format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        }
      end, { desc = "Format file or range (in visual mode)" })
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
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
