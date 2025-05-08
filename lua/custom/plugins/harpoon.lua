return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require "harpoon"
      harpoon:setup({
        settings = {
          sync_on_ui_close = true,
        },
      })

      vim.keymap.set("n", "<leader>a", function()
        harpoon:list():add()
      end)
      vim.keymap.set("n", "<C-e>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)
      vim.keymap.set("n", "<M-j>", function()
        harpoon:list():select(1)
      end)
      vim.keymap.set("n", "<M-f>", function()
        harpoon:list():select(2)
      end)
      vim.keymap.set("n", "<M-k>", function()
        harpoon:list():select(3)
      end)
      vim.keymap.set("n", "<M-d>", function()
        harpoon:list():select(4)
      end)
    end,
  },
  {
    "Soybean44/compilation-mode.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "ThePrimeagen/harpoon" },
    -- dir = "~/code/lua/compilation-mode.nvim", -- for dev
    config = function()
      local compilation_mode = require("compilation-mode")
      compilation_mode.setup({
        send_window = "1",
        send_pane = "0",
        do_swap = true
      })

      vim.keymap.set("n", "<M-c>", function()
        compilation_mode.CompileModeList()
      end)
      vim.keymap.set("n", "<M-r>", function()
        compilation_mode.CompileModeSend()
      end)
    end
  }
}
