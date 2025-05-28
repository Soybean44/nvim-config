local ls = require "luasnip"

vim.keymap.set({ "i", "s" }, "<C-f>", function()
  if ls.jumpable(1) then
    ls.jump(1)
  end
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-b>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, '<C-y>', function()
  ls.expand({})
end, { silent = true })

vim.api.nvim_create_user_command("EditSnippets", function ()
  require("luasnip.loaders").edit_snippet_files()
end, {})

require("luasnip.loaders.from_lua").lazy_load({lazy_paths = {"~/.config/nvim/lua/custom/snippets"}})
