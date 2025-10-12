----------------------------------
-- A Stupidly Simple Neovim Config
----------------------------------

-- Options --

-- Numbers
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.cursorline = true
vim.o.cursorlineopt = "number"

-- Text Formating
vim.o.linebreak = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.autoindent = true

-- smart search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- completion
vim.o.clipboard = 'unnamedplus'
vim.o.winborder = 'rounded'
vim.opt.completeopt:append{"fuzzy", "menuone", "noinsert", "popup"}
vim.opt.complete:remove{"t"}
vim.o.termguicolors = true
vim.o.spelllang = "en_ca"
vim.o.spellsuggest = "best"
vim.o.completefunc = "v:lua.require'snipcomp'"

-- Misc

vim.opt.undofile = true  -- persistent undo history
vim.o.swapfile = false   -- removes annoying swap file
vim.o.hidden = true      -- swap buffers without having to save changes


-- Keybinds --

vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>x', ':update<CR> :source<CR>', { desc = "Source file" })
vim.keymap.set('n', '<leader>r', ':update<CR> :make<CR>', { desc = "Compile/Run file" })
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = "Delete buffer" })
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = "Next buffer" })
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', { desc = "Previous buffer" })
vim.keymap.set('n', '<leader>bl', ':buffers<CR>', { desc = "List buffers" })
vim.keymap.set('n', '<leader>nh', ':noh<CR>', { desc = "Clear Highlights" })
vim.keymap.set({ 'n', 'v', 'o', 'i', 'x' }, '<C-c>', '<Esc>')
vim.keymap.set({ 'n', 'v', 'o', 'i', 'x' }, '<C-h>', '<C-w>h')
vim.keymap.set({ 'n', 'v', 'o', 'i', 'x' }, '<C-j>', '<C-w>j')
vim.keymap.set({ 'n', 'v', 'o', 'i', 'x' }, '<C-k>', '<C-w>k')
vim.keymap.set({ 'n', 'v', 'o', 'i', 'x' }, '<C-l>', '<C-w>l')

-- LSP --

-- Settings
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

-- Language Servers
vim.lsp.enable({ 'lua_ls', 'tinymist', 'clangd', 'pylsp' })

-- PLUGINS --

vim.pack.add({
  { src = 'https://github.com/catppuccin/nvim' },
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/nvim-mini/mini.pick' },
  { src = 'https://github.com/chomosuke/typst-preview.nvim' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/L3MON4D3/LuaSnip' },
  { src = 'https://github.com/iurimateus/luasnip-latex-snippets.nvim' },
  { src = 'https://github.com/rafamadriz/friendly-snippets' },
})



-- Plugin Configuration

require('mini.pick').setup({
  window = {
    config = function()
      local height = math.floor(0.618 * vim.o.lines)
      local width = math.floor(0.618 * vim.o.columns)
      return {
        anchor = 'NW',
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
      }
    end
  }
})
vim.keymap.set('n', '<leader>ff', ':Pick files<CR>')
vim.keymap.set('n', '<leader>fh', ':Pick help<CR>')

require('oil').setup()
vim.keymap.set('n', '-', ':Oil<CR>', { desc = 'Open parent directory' })

require("nvim-treesitter.configs").setup({
  ensure_installed = { "typst", "lua", "python", "c", "cpp", "jinja", "html", "javascript", "css" },
  highlight = { enable = true }
})

local ls = require("luasnip")

vim.keymap.set({ "i", "s" }, "<C-f>", function()
  if ls.jumpable(1) then
    ls.jump(1)
  end
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-b>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })
--
-- set keybinds for both INSERT and VISUAL.
vim.keymap.set({"i", "s"}, "<C-n>", "<Plug>luasnip-next-choice", {})
vim.keymap.set({"i", "s"}, "<C-p>", "<Plug>luasnip-prev-choice", {})

vim.keymap.set({ "i", "s" }, '<C-s>', function()
  ls.expand({})
end, { silent = true })

vim.api.nvim_create_user_command("EditSnippets", function ()
  require("luasnip.loaders").edit_snippet_files()
end, {})

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").lazy_load({ lazy_paths = {"./lua/custom/snippets"} })

require('catppuccin').setup({
  flavour = 'mocha',
  transparent_background = not vim.g.neovide,
})

vim.cmd('colorscheme catppuccin')
