local cmp = require "cmp"
require "custom.config.luasnip"
local ls = require "luasnip"

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

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
