return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = function()
      require "custom.config.neogit"
    end,
  },
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
    'TobinPalmer/pastify.nvim',
    cmd = { 'Pastify', 'PastifyAfter' },
    config = function()
      require('pastify').setup {
        opts = {
          absolute_path = false,   -- use absolute or relative path to the working directory
          apikey = '',             -- Api key, required for online saving
          local_path = '/assets/', -- The path to put local files in, ex ~/Projects/<name>/assets/images/<imgname>.png
          save = 'local',          -- Either 'local' or 'online' or 'local_file'
          filename = function() return vim.fn.expand("%:t:r") .. '_' .. os.date('%Y-%m-%d_%H-%M-%S') end,
          default_ft = 'markdown', -- Default filetype to use
        }
      }
      vim.api.nvim_set_keymap('n', '<leader>P', ':Pastify<CR>', { noremap = true, silent = true })
    end
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
}
