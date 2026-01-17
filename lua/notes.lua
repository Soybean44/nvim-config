--------------------------------------------
-- All note related items in a modular file.
-- This file uses ftplugins for typst files.
-- This file is completely optional
--------------------------------------------


vim.pack.add({
  { src = 'https://github.com/chomosuke/typst-preview.nvim' },
  { src = 'https://github.com/L3MON4D3/LuaSnip' },
  { src = 'https://github.com/iurimateus/luasnip-latex-snippets.nvim' },
  { src = 'https://github.com/rafamadriz/friendly-snippets' },
})

local ls = require("luasnip")

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
--
-- set keybinds for both INSERT and VISUAL.
vim.keymap.set({"i", "s"}, "<C-n>", "<Plug>luasnip-next-choice", {})
vim.keymap.set({"i", "s"}, "<C-p>", "<Plug>luasnip-prev-choice", {})

vim.keymap.set({ "i", "s" }, '<C-s>', function()
  ls.expand({})
end, { silent = true })

vim.api.nvim_create_user_command("EditSnippets", function ()
  require("luasnip.loaders").edit_snippet_files()
end, {})

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").lazy_load({ lazy_paths = {"./lua/custom/snippets"} })

local function snippet2completion(snippet)
  return {
    word      = snippet.trigger,
    menu      = snippet.name,
    info      = vim.trim(table.concat(vim.iter({snippet.dscr or "", "", snippet:get_docstring()}):flatten(), "\n")),
    dup       = true,
    user_data = "luasnip"
  }
end

local function snippetfilter(line_to_cursor, base)
  return function(s)
    return not s.hidden and vim.startswith(s.trigger, base) and s.show_condition(line_to_cursor)
  end
end

-- Set 'completefunc' or 'omnifunc' to "v:lua.require'snipcomp'.completefunc" to get
-- completion.
function completefunc(findstart, base)
  local line, col = vim.api.nvim_get_current_line(), vim.api.nvim_win_get_cursor(0)[2]
  local line_to_cursor = line:sub(1, col)

  if findstart == 1 then
    return vim.fn.match(line_to_cursor, '\\k*$')
  end

  local snippets = vim.list_extend(vim.list_slice(ls.get_snippets("all")), ls.get_snippets(vim.bo.filetype))
  snippets = vim.tbl_filter(snippetfilter(line_to_cursor, base), snippets)
  snippets = vim.tbl_map(snippet2completion, snippets)
  table.sort(snippets, function(s1, s2) return s1.word < s2.word end)
  return snippets
end

vim.api.nvim_create_augroup("luasnip_completion_expand", {clear = true})
vim.api.nvim_create_autocmd("CompleteDone", {
  group = "luasnip_completion_expand",
  callback = function()
    if vim.v.completed_item.user_data == "luasnip" and ls.expandable() then
      ls.expand()
    end
  end
})
vim.o.completefunc = "v:lua.completefunc"

local function whereis(bin)
  local p = vim.fn.systemlist('whereis -b ' .. bin)[1] or ''
  -- "tinymist: /usr/bin/tinymist" -> "/usr/bin/tinymist"
  return p:match('^%S+:%s*(%S+)') or nil
end

require("typst-preview").setup{
  debug = true,
  dependencies_bin = {
    ["tinymist"] = whereis('tinymist'),
    ["websocat"] = whereis('websocat'),
  }
}
