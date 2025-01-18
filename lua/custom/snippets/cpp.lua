local ls = require "luasnip"
-- some shorthands...
local snip = ls.snippet
local text = ls.text_node

ls.add_snippets(nil, {
  cpp = {
    snip({
      trig = "hello",
      namr = "hello world",
      dscr = "hello world program",
    }, {
      text {
        "#include <iostream>",
        "",
        "int main (void) {",
        '  std::cout << "Hello World!" << std::endl;',
        "  return 0;",
        "}",
      },
    }),
  },
})
