local ls = require "luasnip"
-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmta = require("luasnip.extras.fmt").fmta

return {
  s({trig = "hello"},fmta([[#include <<stdio.h>>

int main(void) {
  printf("Hello World!\n");
  return 0;
}]], {})),
}
