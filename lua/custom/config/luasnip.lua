local ls = require "luasnip"
-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)) do
  loadfile(ft_path)()
end

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

vim.keymap.set({ "i", "s" }, '<C-y>', function()
  ls.expand()
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
})
