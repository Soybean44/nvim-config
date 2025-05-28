local treesitter = true

require("luasnip-latex-snippets").setup {
  use_treesitter = treesitter,
  allow_on_markdown = true,
}

-- Modify existing snippets using higher priority and util function from luasnip-latex-snippets
local ls = require "luasnip"
ls.config.setup {
  enable_autosnippets = true,
  store_selection_keys = "<Tab>",
}

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmta = require("luasnip.extras.fmt").fmta
local utils = require "luasnip-latex-snippets.util.utils"
local not_math = utils.with_opts(utils.not_math, treesitter) -- when using treesitter, change false to true

-- Tex specific snippets
local snippets = {
  s({ trig = "test" }, t("Hello world")),
  s(
    { trig = "plot", snippetType = "snippet", priority = 100 },
    fmta([[
    \begin{tikzpicture}
      \begin{axis}[
      legend pos=outer north east,
      title=<>,
      axis lines = box,
      xlabel = <>,
      ylabel = <>,
      xmin = <>, xmax = <>,
      ymin = <>, ymax = <>,
      variable = x,
      trig format plots = rad,
      ]
      <>
      \end{axis}
    \end{tikzpicture}
    ]], {
      i(1, "Plot Title"),
      i(2, "x"),
      i(3, "y"),
      i(4, "-10"),
      i(5, "10"),
      i(6, "-10"),
      i(7, "10"),
      i(8),
    }),
    { condition = not_math }
  )
}

return snippets, require("custom/snippets/math")
