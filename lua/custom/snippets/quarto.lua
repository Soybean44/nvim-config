local ls = require "luasnip"
-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local snippets =  {
  s({
    trig = "pycode",
    namr = "Python codeblock",
    dscr = "Python codeblock",
  }, {
    t { "```{python}", "" },
    i(1, "code"),
    t { "", "```" },
  }),   -- For r version of this snippet just use <M-r>
  s({
    trig = "info",
    namr = "Info",
    dscr = "Document Info",
  }, {
    t { "---", "" },
    t { "title: " },
    i(1, "code"),
    t { "", "jupyter: python3" },
    t { "", "---" },
  }),
}

return snippets, require("custom/snippets/math")
