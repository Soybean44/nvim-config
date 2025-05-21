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

ls.add_snippets("typst", {
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
  s({ trig = "([a-zA-Z])vec", regTrig = true, snippetType = "autosnippet", priority = 101 },
    f(function(args, snip)
      return
          "arrow(" .. snip.captures[1] .. ")"
    end, {}),
    { condition = math }
  ),
  s({ trig = "([a-zA-Z])bar", regTrig = true, snippetType = "autosnippet", priority = 101 },
    f(function(args, snip)
      return
          "overline(" .. snip.captures[1] .. ")"
    end, {}),
    { condition = math }
  ),
  s({ trig = "txt", snippetType = "autosnippet", priority = 1 },
    fmta('op("<>")', { i(1) }), { condition = math }),

  s({ trig = "qed", snippetType = "autosnippet", priority = 1 },
    { t("#align(right)[#square(width:0.9em, stroke:0.5pt)]") }, { condition = not_math }),

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
})

vim.keymap.set('i', '<M-l>', function()
  print(math())
end, { noremap = true })
