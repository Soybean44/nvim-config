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
    s({
      trig = "info",
      namr = "Info Metadata",
      dscr = "Info metadata for python files",
    }, {
      t { '"""', "Title: " },
      i(1, "note_title"),
      t { "", "Author: Sovereign Shahid" },
      t { "", "Date: " },
      f(date, {}),
      t { "", '"""' },
    }),
    s({
      trig = "main",
      namr = "Main Code Block",
      dscr = "creates if name == main block",
    }, {
      t { 'if __name__ == "__main__":', "\t" },
    }),
    s(
      {
        trig = "def",
        namr = "function",
        descr = "creates a function",
      },
      fmt(
        [[
        def {}({}):
          {}
        ]],
        {
          i(1, "func_name"),
          i(2),
          i(3, "pass"),
        },
        {
          indent_string = [[\t]],
        }
      )
    ),
  },
})
