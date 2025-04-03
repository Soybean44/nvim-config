require("luasnip-latex-snippets").setup()
-- Modify existing snippets using higher priority and util function from luasnip-latex-snippets
local ls = require "luasnip"
ls.config.setup { enable_autosnippets = true }
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmta = require("luasnip.extras.fmt").fmta
local utils = require "luasnip-latex-snippets.util.utils"
local not_math = utils.with_opts(utils.not_math, false) -- when using treesitter, change false to true
local math = utils.with_opts(utils.is_math, false)

ls.add_snippets("tex", {
  s(
    { trig = "mk", snippetType = "autosnippet", priority = 100 },
    fmta("$<>$<>", { i(1), i(2) }),
    { condition = not_math }
  ),
  s(
    { trig = "dm", snippetType = "autosnippet", priority = 100 },
    fmta("$$\n<>\n$$<>", { i(1), i(2) }),
    { condition = not_math }
  ),
  s(
    { trig = "vec", snippetType = "autosnippet", priority = 100 },
    fmta("\\vec{<>}<>", {
      i(1),
      i(2)
    }),
    { condition = math }
  ),
  s(
    { trig = "\"", snippetType = "autosnippet", priority = 100 },
    fmta("\\text{<>}<>", {
      i(1),
      i(2)
    }),
    { condition = math }
  ),
  s(
    { trig = "avg", snippetType = "autosnippet", priority = 100 },
    fmta("\\langle <> \\rangle<>", {
      i(1),
      i(2)
    }),
    { condition = math }
  ),
  s(
    { trig = "par", snippetType = "autosnippet", priority = 100 },
    fmta("\\frac{\\partial <>}{\\partial <>}<>", {
      i(1, "y"),
      i(2, "x"),
      i(3)
    }),
    { condition = math }
  ),
  s({ trig = "\\,,", snippetType = "autosnippet", priority = 101 }, t ",\\,", { condition = math }),
  s({ trig = ",,", snippetType = "autosnippet", priority = 101 }, t "\\,", { condition = math }),
  s({ trig = "0+", snippetType = "autosnippet", priority = 100 }, t "\\[0+\\]", { condition = math }),
  s({ trig = "0-", snippetType = "autosnippet", priority = 100 }, t "\\[0-\\]", { condition = math }),
  s(
    { trig = "gath", snippetType = "autosnippet", priority = 100 },
    fmta("\\begin{gather}\n<>\n\\end{gather}<>", { i(1), i(2) }),
    { condition = not_math }
  ),
  -- ...
})
