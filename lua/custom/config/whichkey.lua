local wk = require "which-key"

local keymap = {
  ["<C-n>"] = { ":NvimTreeOpen<CR>", "Open Nvim Tree" },
  ["<leader>"] = {
    b = { ":bd<CR>", "delete buffer" },
    d = {
      name = "+Dap",
      b = { "<Cmd>DapToggleBreakpoint<CR>", "toggle breakpoint" },
      r = { "<Cmd>DapContinue<CR>", "run debugger" },
    },
    f = { -- set a nested structure
      name = "+find",
      b = { "<Cmd>Telescope buffers<CR>", "buffers" },
      h = { "<Cmd>Telescope help_tags<CR>", "help tags" },
      f = { "<Cmd>Telescope find_files<CR>", "find files" },
      a = { "<Cmd>Telescope find_files no_ignore=true<CR>", "find all files" },
      c = {
        name = "+commands",
        c = { "<Cmd>Telescope commands<CR>", "commands" },
        h = { "<Cmd>Telescope command_history<CR>", "history" },
      },
      g = {
        name = "+git",
        g = { "<Cmd>Telescope git_commits<CR>", "commits" },
        c = { "<Cmd>Telescope git_bcommits<CR>", "bcommits" },
        b = { "<Cmd>Telescope git_branches<CR>", "branches" },
        s = { "<Cmd>Telescope git_status<CR>", "status" },
      },
      q = { "<Cmd>Telescope quickfix<CR>", "quickfix" },
    },
    p = {
      name = "+pyscratch",
      r = { ":w !python<CR>", "run buffer"},
      o = { function ()
        vim.cmd[[
        tabnew
        set filetype=python
        ]]
      end, "run buffer"},
      q = { ":q!<CR>", "quit buffer"},
    },
    v = { ":vsplit<CR>", "vertical split" },
    h = { ":split<CR>", "horizontal split" },
    x = { ":w<CR>:source %<CR>", "write & source file" },
  },
}
wk.register(keymap)
