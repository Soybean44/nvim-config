return {
  "nvim-tree/nvim-web-devicons",
  {
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    lazy = false,
    config = function()
      require "custom.config.lualine"
    end,
  },
  "nvim-lua/plenary.nvim",
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    lazy = false,
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    },
    config = function()
      local telescope = require "telescope.builtin"
      vim.keymap.set("n", "<leader>gb", telescope.git_branches)
      vim.keymap.set("n", "<leader>fb", telescope.buffers)
      vim.keymap.set("n", "<leader>fh", telescope.help_tags)
      vim.keymap.set("n", "<leader>ff", telescope.find_files)
      vim.keymap.set("n", "<leader>fk", telescope.keymaps)
      vim.keymap.set("n", "<leader>fg", telescope.grep_string)
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      preview = { icon_provider = "devicons" },
      latex = { enable = false },
      typst = {
        enable = true,
        escapes = { enable = false },
      }
    }
  },
}
