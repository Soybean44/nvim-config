local cmp = require "cmp"
local ls = require "luasnip"

local lspkind = require "lspkind"
lspkind.init {}

vim.opt.completeopt = { "menu", "noinsert", "noselect" }
vim.opt.shortmess:append "c"

cmp.setup {
  completion = {
    autocomplete = false
  },
  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body)
    end,
  },
  performance = {
    max_view_entries = 7,
  },
  sources = cmp.config.sources {
    { name = "luasnip" }, -- For luasnip users.
    { name = "nvim_lsp" },
    { name = "lazydev" },
    { name = "emmet_vim" },
    { name = "path" },
    { name = "buffer" },
  },
  mapping = {
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-y>"] = cmp.mapping(
      cmp.mapping.confirm {
        behaviour = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),
  },
  formatting = {
    format = lspkind.cmp_format {
      mode = "symbol", -- show only symbol annotations
      maxwidth = {
        -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        -- can also be a function to dynamically calculate max width such as
        -- menu = function() return math.floor(0.45 * vim.o.columns) end,
        menu = 50,              -- leading text (labelDetails)
        abbr = 50,              -- actual suggestion item
      },
      ellipsis_char = "...",    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      show_labelDetails = true, -- show labelDetails in menu. Disabled by default

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function(entry, vim_item)
        -- ...
        return vim_item
      end,
    },
  },
}
