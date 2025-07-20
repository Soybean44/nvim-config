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
    branch = "master",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
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
      require("telescope").load_extension("ui-select")
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      experimental = { check_rtp = false },
      preview = { icon_provider = "devicons" },
      latex = { enable = false },
      typst = {
        enable = true,
        math_blocks = { enable = false },
        math_spans = { enable = false },
        code_blocks = { enable = false },
        code_spans = { enable = false },
        escapes = { enable = false },
        headings = { enable = true },
        labels = { enable = false },
        list_items = { enable = false },
        raw_spans = { enable = false },
        raw_blocks = { enable = false },
        reference_links = { enable = false },
        subscripts = { enable = false },
        superscript = { enable = false },
        symbols = { enable = false },
        terms = { enable = false },
        url_links = { enable = true },
      }
    }
  },
}
