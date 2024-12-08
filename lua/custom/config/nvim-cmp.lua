local cmp = require "cmp"
require "custom.config.luasnip"
local ls = require "luasnip"

cmp.setup {
  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources {
    { name = "luasnip" }, -- For luasnip users.
    { name = "nvim_lsp" },
    { name = "emmet_vim" },
    { name = "lazydev" },
    { name = "buffer" },
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-y>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.config.dissable,
  },
}
