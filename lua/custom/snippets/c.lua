local ls = require "luasnip"
-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmta = require("luasnip.extras.fmt").fmta

return {
  s({trig = "hello"}, {
    t {
      "#include <stdio.h>",
      "",
      "int main (void) {",
      '  printf("Hello World!\\n");',
      "  return 0;",
      "}",
    },
  }),
  s({trig = "for"}, fmta([[for (int <1>=<2>; <1> <3> <4>; <1><5>) {  
  <6>
}]],{
    i(1, "i"),
    i(2, "0"),
    c(3, {
      t(">"),
      t(">="),
      t("<"),
      t("<="),
    }),
    i(4, "n"),
    c(5, {
      t("++"),
      t("--"),
    }),
    i(6)
  }))
}
