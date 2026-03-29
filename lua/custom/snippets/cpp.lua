local ls = require "luasnip"
-- some shorthands...
local s = ls.snippet
local fmta = require("luasnip.extras.fmt").fmta

return {
  s({
    trig = "hello",
    namr = "hello world",
    dscr = "hello world program",
  }, fmta([[#include <iostream>"
int main (void) {
  std::cout << "Hello World!\\n"
  return 0;
}]], {})
),
}
