return {
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
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          svelte = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          graphql = { "prettier" },
          lua = { "stylua" },
          python = { "isort", "black" },
          cpp = { "astyle" },
          c = { "astyle" },
          rust = { "rustfmt" },
        },
        formatters = {
          astyle = {
            prepend_args = {"-A14", "-t"}
          },
          rustfmt = {
            prepend_args = {"--edition", "2021"}
          }
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
    "folke/neodev.nvim",
    dependencies = "neovim/nvim-lspconfig",
    opts = {
      library = {
        enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
        -- these settings will be used for your Neovim config directory
        runtime = true, -- runtime path
        types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
        plugins = true, -- installed opt or start plugins in packpath
        -- you can also specify the list of plugins to make available as a workspace library
        -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
      },
      setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
      -- for your Neovim config directory, the config.library settings will be used as is
      -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
      -- for any other directory, config.library.enabled will be set to false
      override = function(root_dir, options) end,
      -- With lspconfig, Neodev will automatically setup your lua-language-server
      -- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
      -- in your lsp start options
      lspconfig = true,
      -- much faster, but needs a recent built of lua-language-server
      -- needs lua-language-server >= 3.6.0
      pathStrict = true,
    }
  },
}
