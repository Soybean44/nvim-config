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
        highlight_overrides = {
          mocha = function(mocha)
            return {
              Todo = { fg = mocha.yellow, bg = mocha.base },
            }
          end,
        },
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
          cpp = { "astyle" },
        },
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
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls", "rust_analyzer", "pylsp", "texlab", "zls", "svelte", "ltex" },
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
      -- <C-y> , to use emmet
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
      require("dap-python").setup "/home/soybean44/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
    end,
  },
  --{
  --  "rcarriga/nvim-dap-ui",
  --  dependencies = "mfussenegger/nvim-dap",
  --  config = function()
  --    local dap, dapui = require "dap", require "dapui"
  --    dap.listeners.after.event_initialized["dapui_config"] = function()
  --      dapui.open()
  --    end
  --    dap.listeners.before.event_terminated["dapui_config"] = function()
  --      dapui.close()
  --    end
  --    dap.listeners.before.event_exited["dapui_config"] = function()
  --      dapui.close()
  --    end
  --  end,
  --},
  {
    "tpope/vim-markdown",
    ft = "markdown",
    config = function()
      vim.g.markdown_fenced_languages = { "html", "python", "bash=sh" }
    end,
  },
  {
    "David-Kunz/gen.nvim",
    config = function()
      require("gen").model = "mistral:instruct" -- default 'mistral:instruct'
    end,
  },
  {
    "andweeb/presence.nvim",
    opts = {
      -- General options
      auto_update = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
      neovim_image_text = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
      main_image = "file", -- Main image display (either "neovim" or "file")
      log_level = nil, -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
      debounce_timeout = 10, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
      enable_line_number = false, -- Displays the current line number instead of the current project
      blacklist = {}, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
      buttons = true, -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
      file_assets = {}, -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
      show_time = true, -- Show the timer

      -- Rich Presence text options
      editing_text = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
      file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
      git_commit_text = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
      plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
      reading_text = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
      workspace_text = "Working on %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
      line_number_text = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
    },
  },
  {
    "eriks47/generate.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require "harpoon"

      harpoon:setup()

      vim.keymap.set("n", "<leader>a", function()
        harpoon:list():append()
      end)
      vim.keymap.set("n", "<C-e>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set("n", "<C-h>", function()
        harpoon:list():select(1)
      end)
      vim.keymap.set("n", "<C-t>", function()
        harpoon:list():select(2)
      end)
      vim.keymap.set("n", "<C-d>", function()
        harpoon:list():select(3)
      end)
      vim.keymap.set("n", "<C-s>", function()
        harpoon:list():select(4)
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<C-b>", function()
        harpoon:list():prev()
      end)
      vim.keymap.set("n", "<C-f>", function()
        harpoon:list():next()
      end)
    end,
  },
}
