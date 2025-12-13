-------------------------------------------------------------------
-- Tmux Command Running for Neovim
-- This script defines a Neovim command to send commmands to the 
-- nex Tmux window. As well it defines a default keybind to it
-- Which runs the command in the variable `vim.b.runcmd`
-- This file is completely optional
-------------------------------------------------------------------

vim.api.nvim_create_user_command('TmuxRunCmd', function(opts)
  local cmd = opts.fargs
  local cmd_str = ''
  if #cmd < 1 then
    cmd_str = vim.b.runcmd or ''
  else
    cmd_str = table.concat(cmd, ' Space ')
  end
  vim.cmd(":!tmux next-window && tmux send-keys \"" .. cmd_str .. "\" Enter")
end, { nargs = '?' })

vim.keymap.set('n', '<leader>r', ':update<CR> :TmuxRunCmd<CR><CR>', { desc = "Compile/Run file" })
