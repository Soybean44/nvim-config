return {
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>-",
        mode = { "n", "v" },
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
    },
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
        change_working_directory = "<c-d>"
      },
    },
  },
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      require("nvim-tmux-navigation").setup {
        disable_when_zoomed = true, -- defaults to false
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
          last_active = "<C-\\>",
          next = "<C-Space>",
        },
      }
    end,
  },
  {
    "ggandor/leap.nvim",
    dependencies = "tpope/vim-repeat",
    config = function()
      local leap = require "leap"
      leap.create_default_mappings()
    end,
  },
  {
    "nosduco/remote-sshfs.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    init = function()
      require('remote-sshfs').setup {
        ui = {
          confirm = {
            connect = false
          }
        }
      }

      require('telescope').load_extension 'remote-sshfs'
      local api = require('remote-sshfs.api')
      vim.keymap.set('n', '<leader>rm', api.connect, {})
    end
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      -- add options here
      -- or leave it empty to use the default settings
    },
    keys = {
      -- suggested keymap
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',
    opts = {}, -- lazy.nvim will implicitly calls `setup {}`
    vim.keymap.set('n', "<localleader>tp", ":TypstPreviewToggle<CR>", { noremap = true, silent = true })
  },
}
