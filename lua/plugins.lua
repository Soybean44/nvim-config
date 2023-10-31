require("lazy").setup {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    init = function()
      require("catppuccin").setup {
        flavour = "mocha",
        transparent_background = true,
      }
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  "nvim-tree/nvim-web-devicons",
  {
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    lazy = false,
    config = function()
      require "config.lualine"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    config = function()
      require("nvim-treesitter.configs").setup {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = { "python", "lua", "vim", "vimdoc", "rust", "c", "cpp", "markdown", "latex" },
      }
    end,
  },
  "nvim-lua/plenary.nvim",
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    lazy = false,
    dependencies = "nvim-lua/plenary.nvim",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "config.lsp"
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    version = "1.x",
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    dependencies = "nvim-cmp",
  },
  {
    "hrsh7th/cmp-buffer",
    dependencies = "nvim-cmp",
  },
  {
    "hrsh7th/cmp-path",
    dependencies = "nvim-cmp",
  },
  {
    "hrsh7th/cmp-path",
    dependencies = "nvim-cmp",
  },
  {
    "hrsh7th/cmp-cmdline",
    dependencies = "nvim-cmp",
  },
  {
    "L3MON4D3/LuaSnip",
  },
  {
    "saadparwaiz1/cmp_luasnip",
    dependencies = { "nvim-cmp", "L3MON4D3/LuaSnip" },
  },
  {
    "williamboman/mason.nvim",
    init = function()
      require("mason").setup {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      }
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
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
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
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls", "rust_analyzer", "pylsp", "texlab", "zls", "svelte" },
        automatic_installation = true,
      }
    end,
  },
  {
    "tpope/vim-fugitive",
    lazy = false,
  },
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/Documents/notes",
              },
            },
          },
        },
      }
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require "config.whichkey"
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    config = true,
  },
  {
    "lervag/vimtex",
    config = function()
      require "config.tex"
    end,
  },
  "othree/html5.vim",
  "pangloss/vim-javascript",
  "HerringtonDarkholme/yats.vim",
  "evanleck/vim-svelte",
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    config = function()
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- set termguicolors to enable highlight groups
      vim.opt.termguicolors = true

      -- empty setup using defaults
      require("nvim-tree").setup()

      -- OR setup with some options
      require("nvim-tree").setup {
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      }
    end,
  },
  "mattn/emmet-vim",
  {
    "alvan/vim-closetag",
    config = function()
      vim.g.closetag_filenames = "*.html,*.xhtml,*.phtml,*.svelte"
    end,
  },
  "kmonad/kmonad-vim",
  "mfussenegger/nvim-dap",
  {
    "mfussenegger/nvim-dap-python",
    dependencies = "mfussenegger/nvim-dap",
    ft = "python",
    config = function()
      require("dap-python").setup "~/home/soybean44/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap, dapui = require "dap", require "dapui"
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}
