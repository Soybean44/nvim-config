local ls = require "luasnip"
-- some shorthands...
local s = ls.snippet
local t = ls.text_node


return {
    s({
      trig = "hello",
      namr = "hello world",
      dscr = "hello world program",
    }, {
      t {
        "#include <stdio.h>",
        "",
        "int main (void) {",
        '  printf("Hello World!\\n");',
        "  return 0;",
        "}",
      },
    }),
  }
