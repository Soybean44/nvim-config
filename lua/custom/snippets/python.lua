local ls = require "luasnip"
-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local fmt = require("luasnip.extras.fmt").fmt

local date = function()
  return { os.date "%Y-%m-%d" }
end
ls.add_snippets(nil, {
  python = {
    s(
      {
        trig = "info",
        namr = "Info Metadata",
        dscr = "Info metadata for python files",
      },
      fmt(
        [[
        """
        Title: {}
        Author: Sovereign Shahid
        Date: {}
        """
        ]],
        {
          i(1, "note_title"),
          f(date, {}),
        }
      )
    ),
    s({
      trig = "main",
      namr = "Main Code Block",
      dscr = "creates if name == main block",
    }, {
      t { 'if __name__ == "__main__":', "\t" },
    }),
  },
})
