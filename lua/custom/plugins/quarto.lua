return {
  "jmbuhr/otter.nvim",
  {
    "jpalardy/vim-slime",
    init = function ()
      vim.g.slime_no_mappings = 1
      vim.g.slime_target = "tmux"

      vim.keymap.set('x', '<leader>s', '<Plug>SlimeRegionSend')
      vim.keymap.set('n', '<leader>s', '<Plug>SlimeMotionSend')
      vim.keymap.set('n', '<leader>ss', '<Plug>SlimeLineSend')
    end
  },
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "jpalardy/vim-slime",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function ()
      require('quarto').setup{
        debug = false,
        closePreviewOnExit = true,
        lspFeatures = {
          enabled = true,
          chunks = "curly",
          languages = { "python" },
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        codeRunner = {
          enabled = false,
          default_method = nil, -- 'molten' or 'slime'
          ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
                           -- Takes precedence over `default_method`
          never_run = { "yaml" }, -- filetypes which are never sent to a code runner
        },
      }
      local runner = require("quarto.runner")
      vim.keymap.set("n", "<leader>rc", runner.run_cell,  { desc = "run cell", silent = true })
      vim.keymap.set("n", "<leader>ra", runner.run_above, { desc = "run cell and above", silent = true })
      vim.keymap.set("n", "<leader>rA", runner.run_all,   { desc = "run all cells", silent = true })
      vim.keymap.set("n", "<leader>rl", runner.run_line,  { desc = "run line", silent = true })
      vim.keymap.set("v", "<leader>r",  runner.run_range, { desc = "run visual range", silent = true })
      vim.keymap.set("n", "<leader>RA", function()
        runner.run_all(true)
      end, { desc = "run all cells of all languages", silent = true })
    end
  },
}
