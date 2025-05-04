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
    }), -- For r version of this snippet just use <M-r>
    snip({
      trig = "info",
      namr = "Info",
      dscr = "Document Info",
    }, {
      text { "---", "" },
      text { "title: " },
      insert(1, "code"),
      text { "", "jupyter: python3" },
      text { "", "---" },
    }),
  },
})
