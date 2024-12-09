local ls = require "luasnip"
-- some shorthands...
local snip = ls.snippet
local text = ls.text_node
local insert = ls.insert_node
ls.add_snippets(nil, {
  quarto = {
    snip({
      trig = "pycode",
      namr = "Python codeblock",
      dscr = "Python codeblock",
    }, {
      text { "```{python}", "" },
      insert(1, "code"),
      text { "", "```" },
    }),
  },
})
