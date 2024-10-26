return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  init = function()
    local function get_bg()
      if vim.g.neovide then
        return false
      end
      return true
    end
    require("catppuccin").setup {
      flavour = "mocha",
      transparent_background = get_bg(),
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
