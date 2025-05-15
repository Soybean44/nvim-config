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
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta
local utils = require "luasnip-latex-snippets.util.utils"
local not_math = utils.with_opts(utils.not_math, treesitter) -- when using treesitter, change false to true
local math = utils.with_opts(utils.is_math, treesitter)

local snippets = {
  -- Non Math Snippets
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
  s(
    { trig = "dm", snippetType = "autosnippet", priority = 100 },
    {
      t({ "$$", "" }),
      f(function(args, snip)
        return
            snip.env.TM_SELECTED_TEXT[1] or {}
      end, {}),
      i(1),
      t({ "", "$$" }),
    },
    { condition = not_math }
  ),
  -- Regex Snippets
  s({ trig = "}(%d)", wordTrig = false, regTrig = true, snippetType = "autosnippet", priority = 100 },
    f(function(args, snip)
      return
          "}_{" .. snip.captures[1] .. "}"
    end, {}),
    { condition = math }
  ),

  s({ trig = "([a-zA-Z])vec", regTrig = true, snippetType = "autosnippet", priority = 101 },
    f(function(args, snip)
      return
          "\\vec{" .. snip.captures[1] .. "}"
    end, {}),
    { condition = math }
  ),
  s(
    { trig = "(%d)par", regTrig = true, snippetType = "autosnippet", priority = 100 },
    {
      t("\\frac{\\partial^"),
      f(function(args, snip)
        return snip.captures[1]
      end, {}),
      t(" "),
      i(1, "f"),
      t("}{\\partial^"),
      f(function(args, snip)
        return snip.captures[1]
      end, {}),
      t(" "),
      i(2, "x"),
      t("} "),
    },
    { condition = math }
  ),
  s({ trig = "iden(%d)", regTrig = true, snippetType = "autosnippet", priority = 100 },
    f(function(args, snip)
      local n = tonumber(snip.captures[1])
      local arr = {}

      for j = 1, n do
        arr[j] = {}
        for k = 1, n do
          arr[j][k] = (k == j) and 1 or 0
        end
      end

      local output = { "\\begin{pmatrix}" }
      for _, el in ipairs(arr) do
        local row = table.concat(el, " & ")
        table.insert(output, row .. "\\\\")
      end
      table.insert(output, "\\end{pmatrix}")
      return output
    end, {}),
    { condition = math }
  ),
  -- multi input math snippets
  s(
    { trig = "vec", snippetType = "autosnippet", priority = 100 },
    fmta("\\vec{<>}<>", {
      i(1),
      i(2)
    }),
    { condition = math }
  ),
  s(
    { trig = "lim", snippetType = "autosnippet", priority = 100 },
    fmta("\\lim_{<> \\to <>} <>", {
      i(1, "x"),
      i(2, "\\infty"),
      i(3)
    }),
    { condition = math }
  ),
  s(
    { trig = "dint", snippetType = "autosnippet", priority = 301 },
    fmta("\\int_{<>}^{<>} <> \\, d<>", {
      i(1, "-\\infty"),
      i(2, "\\infty"),
      i(3),
      i(4, "x")
    }),
    { condition = math }
  ),
  s(
    { trig = "sum", snippetType = "autosnippet", priority = 100 },
    fmta("\\Sigma_{<>=<>}^{<>} \\, <>", {
      i(1, "n"),
      i(2, "1"),
      i(3, "k"),
      i(4)
    }),
    { condition = math }
  ),
  s(
    { trig = "isum", snippetType = "autosnippet", priority = 100 },
    fmta("\\Sigma_{<>=<>}^{\\infty} \\, <>", {
      i(1, "n"),
      i(2, "1"),
      i(3)
    }),
    { condition = math }
  ),
  s(
    { trig = "txt", snippetType = "autosnippet", priority = 110 },
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

  -- Shorthand/No Backslash
  s({ trig = "\\,,", snippetType = "autosnippet", priority = 101 }, t ",\\,", { condition = math }),
  s({ trig = "fall", snippetType = "autosnippet", priority = 101 }, t "\\forall ", { condition = math }),
  s({ trig = "exists", snippetType = "autosnippet", priority = 101 }, t "\\exists ", { condition = math }),
  s({ trig = "det", snippetType = "autosnippet", priority = 101 }, t "\\det ", { condition = math }),
  s({ trig = "and", snippetType = "autosnippet", priority = 101 }, t "\\land ", { condition = math }),
  s({ trig = "or", snippetType = "autosnippet", priority = 101 }, t "\\lor ", { condition = math }),
  s({ trig = "ni", snippetType = "autosnippet", priority = 101 }, t "\\ni ", { condition = math }),
  s({ trig = ",,", snippetType = "autosnippet", priority = 100 }, t "\\,", { condition = math }),
  -- s({ trig = "0+", snippetType = "autosnippet", priority = 100 }, t "\\[0+\\] ", { condition = math }),
  -- s({ trig = "0-", snippetType = "autosnippet", priority = 100 }, t "\\[0-\\] ", { condition = math }),
  s({ trig = "+-", snippetType = "autosnippet", priority = 100 }, t "\\pm ", { condition = math }),
  s({ trig = "-+", snippetType = "autosnippet", priority = 100 }, t "\\mp ", { condition = math }),


  -- Greek Letters
  s({ trig = "Delta", snippetType = "autosnippet", priority = 400 }, t "\\Delta", { condition = math }),
  s({ trig = "delta", snippetType = "autosnippet", priority = 400 }, t "\\delta", { condition = math }),
  s({ trig = "theta", snippetType = "autosnippet", priority = 400 }, t "\\theta", { condition = math }),
  s({ trig = "gamma", snippetType = "autosnippet", priority = 400 }, t "\\gamma", { condition = math }),
  s({ trig = "beta", snippetType = "autosnippet", priority = 400 }, t "\\beta", { condition = math }),
  s({ trig = "alpha", snippetType = "autosnippet", priority = 400 }, t "\\alpha", { condition = math }),
  s({ trig = "omega", snippetType = "autosnippet", priority = 400 }, t "\\omega", { condition = math }),
  s({ trig = "lambda", snippetType = "autosnippet", priority = 400 }, t "\\lambda", { condition = math }),
  s({ trig = "epsilon", snippetType = "autosnippet", priority = 400 }, t "\\epsilon", { condition = math }),
  s({ trig = "sigma", snippetType = "autosnippet", priority = 400 }, t "\\sigma", { condition = math }),
  s({ trig = "Sigma", snippetType = "autosnippet", priority = 400 }, t "\\Sigma", { condition = math }),
  s({ trig = "mu", snippetType = "autosnippet", priority = 400 }, t "\\mu", { condition = math }),
  s({ trig = "pi", snippetType = "autosnippet", priority = 400 }, t "\\pi", { condition = math }),

  s({ trig = "@D", snippetType = "autosnippet", priority = 100 }, t "\\Delta", { condition = math }),
  s({ trig = "@d", snippetType = "autosnippet", priority = 100 }, t "\\delta", { condition = math }),
  s({ trig = "@t", snippetType = "autosnippet", priority = 100 }, t "\\theta", { condition = math }),
  s({ trig = "@g", snippetType = "autosnippet", priority = 100 }, t "\\gamma", { condition = math }),
  s({ trig = "@b", snippetType = "autosnippet", priority = 100 }, t "\\beta", { condition = math }),
  s({ trig = "@a", snippetType = "autosnippet", priority = 100 }, t "\\alpha", { condition = math }),
  s({ trig = "@o", snippetType = "autosnippet", priority = 100 }, t "\\omega", { condition = math }),
  s({ trig = "@l", snippetType = "autosnippet", priority = 100 }, t "\\lambda", { condition = math }),
  s({ trig = "@e", snippetType = "autosnippet", priority = 100 }, t "\\epsilon", { condition = math }),
  s({ trig = "@s", snippetType = "autosnippet", priority = 100 }, t "\\sigma", { condition = math }),
  s({ trig = "@S", snippetType = "autosnippet", priority = 100 }, t "\\Sigma", { condition = math }),
  s({ trig = "@m", snippetType = "autosnippet", priority = 100 }, t "\\mu", { condition = math }),
  s({ trig = "@p", snippetType = "autosnippet", priority = 100 }, t "\\pi", { condition = math }),

  -- Environments
  s(
    { trig = "gath", snippetType = "snippet", priority = 100 },
    fmta("\\begin{gather}\n<>\n\\end{gather}<>", { i(1), i(2) }),
    { condition = not_math }
  ),
  s(
    { trig = "ali", snippetType = "snippet", priority = 100 },
    fmta("\\begin{aligned}\n<>\n\\end{aligned}<>", { i(1), i(2) }),
    { condition = math }
  ),
}

ls.add_snippets("tex", snippets)
ls.add_snippets("markdown", snippets)
ls.add_snippets("quarto", snippets)

-- Tex specific snippets
ls.add_snippets("tex", {
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
  ),
})
