local ls = require "luasnip"
-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

vim.keymap.set({ "i", "s" }, "<C-n>", function()
  if ls.jumpable(1) then
    ls.jump(1)
  end
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-p>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

local date = function()
  return { os.date "%Y-%m-%d" }
end

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
  cpp = {
    snip({
      trig = "hello",
      namr = "hello world",
      dscr = "hello world program",
    }, {
      text { '#include <iostream>',
        '',
        'using namespace std;',
        'int main (void) {',
        '  cout << "Hello World!" << endl;',
        '  return 0;',
        '}'
      },
    })
  },
  python = {
    snip({
      trig = "info",
      namr = "Info Metadata",
      dscr = "Info metadata for python files",
    }, {
      text { '"""', "Title: " },
      insert(1, "note_title"),
      text { "", "Author: Sovereign Shahid" },
      text { "", "Date: " },
      func(date, {}),
      text { "", '"""' },
    }),
    snip({
      trig = "main",
      namr = "Main Code Block",
      dscr = "creates if name == main block",
    }, {
      text { 'if __name__ == "__main__":', "\t" },
    }),
    snip({
      trig = "ret",
      namr = "Return in docstring",
    }, {
      text { "", ":return: " },
      insert(1, "return_desc"),
    }),
    snip({
      trig = "param",
      namr = "Parameter in docstring",
    }, {
      text { "", ":param " },
      insert(1, "arg"),
      text { ": " },
      insert(2, "desc"),
    }),
  },
})
