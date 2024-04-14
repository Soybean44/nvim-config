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
        highlight = {
          enable = true
        }
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
  {
    "neovim/nvim-lspconfig",
    dependencies = "folke/neodev.nvim",
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
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls", "pylsp", "texlab", "zls", "svelte", "ltex" },
        automatic_installation = true,
      }
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true
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
  "nvim-neotest/nvim-nio",
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
    }
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
      ensure_installed = {
        "codelldb",
      }
    }
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = "mfussenegger/nvim-dap",
    ft = "python",
    config = function()
      require("dap-python").setup "/home/soybean44/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
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
    dependencies = { "nvim-lua/plenary.nvim", "EvWilson/slimux.nvim" },
    config = function()
      local harpoon = require "harpoon"

      local function run_command(cmd)
        local function get_os_command_output(cmd, cwd)
          if type(cmd) ~= "table" then
            print("Harpoon: [get_os_command_output]: cmd has to be a table")
            return {}
          end
          local Job = require("plenary.job")
          local command = table.remove(cmd, 1)
          local stderr = {}
          local stdout, ret = Job
          :new({
            command = command,
            args = cmd,
            cwd = cwd,
            on_stderr = function(_, data)
              table.insert(stderr, data)
            end,
          })
          :sync()
          return stdout, ret, stderr
        end
        local _, ret, stderr = get_os_command_output({
          "tmux",
          "send-keys",
          "-t1",
          string.format('%s', cmd),
          ";",
          "send-keys",
          "-t1",
          "Enter",
          ";",
          "select-window",
          "-t1",
        }, vim.loop.cwd())
        print(string.format('sending command: %s', harpoon:list("cmd"):get(1).value))
        if ret ~= 0 then
          if stderr then
            error("Failed to send command. " .. stderr[1])
          end
        end
      end

      harpoon:setup({
        settings = {
          sync_on_ui_close = true,
        },
        ["cmd"] = {
          select = function(list_item, list, option)
            run_command(list_item.value)
          end
        },
      })
      

      vim.keymap.set("n", "<leader>a", function()
        harpoon:list("files"):add()
      end)
      vim.api.nvim_create_user_command("ClearCompileCommands", function()
        harpoon:list("cmd"):clear()
      end, {})
      vim.api.nvim_create_user_command("CompileModeCommand", function(opts)
        print(string.format("Adding command: %s", opts.args))
        harpoon:list("cmd"):clear()
        harpoon:list("cmd"):add(opts.args)
      end, { nargs='?' })
      vim.keymap.set("n", "<C-e>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list("files"))
      end)
      vim.keymap.set("n", "<M-c>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list("cmd"))
      end)

      vim.keymap.set("n", "<M-j>", function()
        harpoon:list("files"):select(1)
      end)
      vim.keymap.set("n", "<M-f>", function()
        harpoon:list("files"):select(2)
      end)
      vim.keymap.set("n", "<M-d>", function()
        harpoon:list("files"):select(3)
      end)
      vim.keymap.set("n", "<M-k>", function()
        harpoon:list("files"):select(4)
      end)
      vim.keymap.set("n", "<M-r>", function()
          run_command(harpoon:list("cmd"):get(1).value)
        end)
    end,
  },
  'ThePrimeagen/vim-be-good',
  {
    "czheo/mojo.vim",
    ft = { "mojo" },
    init = function()
      vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        pattern = { "*.🔥" },
        callback = function()
          if vim.bo.filetype ~= "mojo" then
            vim.bo.filetype = "mojo"
          end
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "mojo",
        callback = function()
          local modular = vim.env.MODULAR_HOME
          local lsp_cmd = modular .. "/pkg/packages.modular.com_mojo/bin/mojo-lsp-server"

          vim.bo.expandtab = true
          vim.bo.shiftwidth = 4
          vim.bo.softtabstop = 4

          vim.lsp.start({
            name = "mojo",
            cmd = { lsp_cmd },
          })
        end,
      })
    end,
  },
  {
    'alexghergh/nvim-tmux-navigation',
    config = function() 
      require'nvim-tmux-navigation'.setup {
        disable_when_zoomed = true, -- defaults to false
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
          last_active = "<C-\\>",
          next = "<C-Space>",
        }
      }
    end
  }
}
