local ls = require "luasnip"

ls.config.setup {
  enable_autosnippets = true,
  store_selection_keys = "<Tab>",
}

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta
local utils = require "luasnip-latex-snippets.util.utils"
local not_math = utils.with_opts(utils.not_math, treesitter) -- when using treesitter, change false to true
local math = utils.with_opts(utils.is_math, treesitter)

ls.add_snippets(nil, {
  typst = {
    s(
      { trig = "mk", snippetType = "autosnippet", priority = 100 },
      {
        t("$"),
        f(function(args, snip)
          return
              snip.env.TM_SELECTED_TEXT[1] or {}
        end, {}),
        i(1),
        t("$"),
      },
      { condition = not_math }
    ),
  },
})
