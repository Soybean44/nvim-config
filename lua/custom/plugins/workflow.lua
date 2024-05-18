return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = function ()
      require "custom.config.neogit"
    end
  },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    config = function()
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 2
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
      vim.keymap.set("n", "<C-n>", "<Cmd>NvimTreeOpen<CR>")
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
  },
  {
    'ggandor/leap.nvim',
    dependencies="tpope/vim-repeat",
    config=function ()
      local leap = require("leap")
      leap.create_default_mappings()
    end
  },
}
