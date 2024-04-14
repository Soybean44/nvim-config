return   {
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
  }

