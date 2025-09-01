vim.treesitter.start()

vim.g.maplocalleader = ","
vim.g.export_typst = true
vim.o.spell = true
vim.keymap.set('n', '<LocalLeader>tp', ':TypstPreview<CR>')

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.typ",
  callback = function ()
    if vim.g.export_typst then
      vim.cmd[[LspTinymistExportPdf]]
    end
  end,
})

vim.api.nvim_create_user_command("AutoPdfToggle", function ()
  vim.g.export_typst = not vim.g.export_typst
  print("Set pdf export to", vim.g.export_typst)
end, {})
