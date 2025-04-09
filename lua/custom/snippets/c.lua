local ls = require "luasnip"
-- some shorthands...
local snip = ls.snippet
local text = ls.text_node

ls.add_snippets(nil, {
  c = {
    snip({
      trig = "hello",
      namr = "hello world",
      dscr = "hello world program",
    }, {
      text {
        "#include <stdio.h>",
        "",
        "int main (void) {",
        '  printf("Hello World!\n");',
        "  return 0;",
        "}",
      },
    }),
  },
})
