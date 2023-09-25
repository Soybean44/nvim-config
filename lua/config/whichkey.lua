local wk = require("whichkey_setup")

wk.config {
  hide_statusline = false,
  default_keymap_settings = {
    silent = true,
    noremap = true,
  },
  default_mode = 'n',
}

local keymap = {

  w = { ':w!<CR>', 'save file' }, -- set a single command and text
  b = { ':bd', 'delete buffer' },
  f = {                           -- set a nested structure
    name = '+find',
    b = { '<Cmd>Telescope buffers<CR>', 'buffers' },
    h = { '<Cmd>Telescope help_tags<CR>', 'help tags' },
    f = { '<Cmd>Telescope find_files<CR>', 'find files' },
    a = { '<Cmd>Telescope find_files no_ignore=true<CR>', 'find all files' },
    c = {
      name = '+commands',
      c = { '<Cmd>Telescope commands<CR>', 'commands' },
      h = { '<Cmd>Telescope command_history<CR>', 'history' },
    },
    q = { '<Cmd>Telescope quickfix<CR>', 'quickfix' },
    g = {
      name = '+git',
      g = { '<Cmd>Telescope git_commits<CR>', 'commits' },
      c = { '<Cmd>Telescope git_bcommits<CR>', 'bcommits' },
      b = { '<Cmd>Telescope git_branches<CR>', 'branches' },
      s = { '<Cmd>Telescope git_status<CR>', 'status' },
    },
  },
  v = { ':vsplit<CR>', 'vertical split' },
}

wk.register_keymap('leader', keymap)
