local ls = require("luasnip")
-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

local date = function() return { os.date('%Y-%m-%d') } end

ls.add_snippets(nil, {
  all = {
    snip({
      trig = "date",
      namr = "Date",
      dscr = "Date in the form of YYYY-MM-DD",
    }, {
      func(date, {}),
    }),
  },
  python = {
    snip({
        trig = "info",
        namr = "Info Metadata",
        dscr = "Info metadata for python files"
      },
      {
        text({ "\"\"\"",
          "Title: " }), insert(1, "note_title"), text({ "",
        "Author: Soverign Shahid" }), text({ "",
        "Date: " }), func(date, {}), text({ "", "\"\"\"" })
      }),
    snip({
      trig = "main",
      namr = "Main Code Block",
      dscr = "creates if name == main block"
    }, {
      text({ "if __name__ == \"__main__\":", "\t" })
    })
  }
})
