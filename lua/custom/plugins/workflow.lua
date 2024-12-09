return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = function()
      require "custom.config.neogit"
    end,
  },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      default_file_explorer = true,
    },
    config = function()
      vim.keymap.set({ "n", "v" }, "<C-n>", "<CMD>Oil<CR>")
    end,
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
}
