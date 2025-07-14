return {
  'ThePrimeagen/vim-be-good',
  {
    "mistricky/codesnap.nvim",
    build = "make",
    init = function()
      local codesnap = require('codesnap')
      vim.api.nvim_create_user_command("CodeSnapAll", function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('moggVGy`o:CodeSnap<CR>', true, false, true), 'n', false)
      end, {})
    end
  },
  {
    'davidgranstrom/scnvim',
    ft = 'supercollider',
    config = function()
      require("custom.config.scnvim")
    end
  }
}
