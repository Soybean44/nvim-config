local ls = require "luasnip"

ls.config.setup {
  enable_autosnippets = true,
  store_selection_keys = "<Tab>",
}

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local utils = require "luasnip-latex-snippets.util.utils"

-- Checks if current cursor location has node_name as a rott
local ts_has_root = function(node_name)
  -- Get the current cursor position
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1              -- Convert to 0-indexed
  col = math.max(0, col - 1) -- Fixes the issue that last char of line not included in comment

  -- Get the treesitter parser for the current buffer
  local bufnr = vim.api.nvim_get_current_buf()
  local filetype = vim.bo[bufnr].filetype
  local parser = vim.treesitter.get_parser(bufnr, filetype, {})

  if not parser then
    print("No parser available for the current buffer")
    return
  end

  -- Get the syntax tree
  local tree = parser:parse()[1]
  if not tree then
    print("No syntax tree available")
    return
  end

  local root = tree:root()
  local node_at_cursor = root:named_descendant_for_range(row, col, row, col)

  -- Walk up the tree to find a math node
  local current_node = node_at_cursor
  local has_root = false

  while current_node do
    if current_node:type() == node_name then
      has_root = true
      break
    end
    current_node = current_node:parent()
  end

  return has_root
end

local not_math = function()
  return not ts_has_root("math")
end

local math = function()
  return ts_has_root("math")
end

vim.keymap.set('i', '<M-l>', function()
  print(math())
end, { noremap = true })

return {
  s(
    { trig = "mk", snippetType = "autosnippet", priority = 1 },
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
    { trig = "dm", snippetType = "autosnippet", priority = 1 },
    {
      t({ "$", "" }),
      f(function(args, snip)
        return
            snip.env.TM_SELECTED_TEXT[1] or {}
      end, {}),
      i(1),
      t({ "", "$" }),
    },
    { condition = not_math }
  ),
  -- Regex / Functions
  s({ trig = "([a-zA-Z])vec", regTrig = true, snippetType = "autosnippet", priority = 101 },
    f(function(args, snip)
      return
          "arrow(" .. snip.captures[1] .. ")"
    end, {}),
    { condition = math }
  ),
  s({ trig = "(%d)ddx", regTrig = true, snippetType = "autosnippet", priority = 101 },
    {
      f(function(args, snip)
        return '(d^(' .. snip.captures[1] .. ') '
      end, {}),
      i(1),
      t(')/(d '),
      i(2, "x"),
      f(function(args, snip)
        return '^(' .. snip.captures[1] .. ')) '
      end, {}),
    },
    { condition = math }
  ),
  s({ trig = "(%d)par", regTrig = true, snippetType = "autosnippet", priority = 101 },
    {
      f(function(args, snip)
        return '(partial^(' .. snip.captures[1] .. ') '
      end, {}),
      i(1),
      t(')/(partial '),
      i(2, "x"),
      f(function(args, snip)
        return '^(' .. snip.captures[1] .. ')) '
      end, {}),
    },
    { condition = math }
  ),

  s({ trig = "([a-zA-Z])bar", regTrig = true, snippetType = "autosnippet", priority = 101 },
    f(function(args, snip)
      return
          "overline(" .. snip.captures[1] .. ")"
    end, {}),
    { condition = math }
  ),
  s({ trig = "([a-zA-Z])hat", regTrig = true, snippetType = "autosnippet", priority = 101 },
    f(function(args, snip)
      return
          "hat(" .. snip.captures[1] .. ")"
    end, {}),
    { condition = math }
  ),
  s({ trig = "([a-zA-Z])(%d)", regTrig = true, snippetType = "autosnippet", priority = 101 },
    f(function(args, snip)
      return
          snip.captures[1] .. "_(" .. snip.captures[2] .. ")"
    end, {}),
    { condition = math }
  ),

  -- Math Expressions
  s({ trig = "txt", snippetType = "autosnippet", priority = 1 },
    fmt('op("{}")', { i(1) }), { condition = math }),
  s({ trig = "lim", snippetType = "autosnippet", priority = 1 },
    fmt('lim_({} -> {})', { i(1, "x"), i(2, "oo") }), { condition = math }),
  s({ trig = "dint", snippetType = "autosnippet", priority = 1 },
    fmt('integral_({})^({}) {} thin d {}', { i(1, "a"), i(2, "b"), i(3, "f(x)"), i(4, "x") }), { condition = math }),
  s({ trig = "ddx", snippetType = "autosnippet", priority = 1 },
    fmt('(d {})/(d {})', { i(1), i(2, "x") }), { condition = math }),
  s({ trig = "par", snippetType = "autosnippet", priority = 1 },
    fmt('(partial {})/(partial {})', { i(1), i(2, "x") }), { condition = math }),

  s({ trig = "genmat", snippetType = "autosnippet", priority = 1 },
    fmt([[
#let n = {}
#let m = {}
#let f(i,j) = {}
mat(..#range(0,n).map(i => range(0,m).map(j => f(i,j))))
    ]], { i(1, "2"), i(2, "2"), i(3, "$#{int(i==j)}$") }), { condition = math }),

  -- Shorthand
  s({ trig = "qed", snippetType = "autosnippet", priority = 1 },
    { t("#align(right)[#square(width:0.9em, stroke:0.5pt)]") }, { condition = not_math }),
  s({ trig = "+-", snippetType = "autosnippet", priority = 100 }, t "plus.minus", { condition = math }),
  s({ trig = "-+", snippetType = "autosnippet", priority = 100 }, t "minus.plus", { condition = math }),
  s({ trig = "int", snippetType = "autosnippet", priority = 100 }, t "integral", { condition = math }),

  -- Greek Shorthand
  s({ trig = "@D", snippetType = "autosnippet", priority = 100 }, t "Delta", { condition = math }),
  s({ trig = "@d", snippetType = "autosnippet", priority = 100 }, t "delta", { condition = math }),
  s({ trig = "@t", snippetType = "autosnippet", priority = 100 }, t "theta", { condition = math }),
  s({ trig = "@g", snippetType = "autosnippet", priority = 100 }, t "gamma", { condition = math }),
  s({ trig = "@b", snippetType = "autosnippet", priority = 100 }, t "beta", { condition = math }),
  s({ trig = "@a", snippetType = "autosnippet", priority = 100 }, t "alpha", { condition = math }),
  s({ trig = "@o", snippetType = "autosnippet", priority = 100 }, t "omega", { condition = math }),
  s({ trig = "@l", snippetType = "autosnippet", priority = 100 }, t "lambda", { condition = math }),
  s({ trig = "@e", snippetType = "autosnippet", priority = 100 }, t "epsilon", { condition = math }),
  s({ trig = "@s", snippetType = "autosnippet", priority = 100 }, t "sigma", { condition = math }),
  s({ trig = "@S", snippetType = "autosnippet", priority = 100 }, t "Sigma", { condition = math }),
  s({ trig = "@m", snippetType = "autosnippet", priority = 100 }, t "mu", { condition = math }),
  s({ trig = "@p", snippetType = "autosnippet", priority = 100 }, t "pi", { condition = math }),
}
