local wk = require("which-key")

local keymap = {
  ["<leader>"] = {
    w = { ':w!<CR>', 'save file' }, -- set a single command and text
    q = { ':q!<CR>', 'quit file' }, -- set a single command and text
    b = { ':bd', 'delete buffer' },
    g = {
      name = '+git',
      s = { '<Cmd>Git<CR>', 'git status' },
      p = { '<Cmd>Git push<CR>', 'git push' },
    },
    f = { -- set a nested structure
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
    n = {
      name = '+neorg',
      n = { '<Cmd> Neorg keybind norg core.dirman.new.note<CR>', 'new note' },
      o = { '<Cmd> Neorg workspace notes<CR>', 'open notes' },
    },
    v = { ':vsplit<CR>', 'vertical split' },
    h = { ':split<CR>', 'horizontal split' },
  }
}
wk.register(keymap)
