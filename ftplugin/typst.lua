vim.treesitter.start()

vim.b.maplocalleader = ","
vim.b.export_typst = true
vim.o.spell = true
vim.keymap.set('n', '<LocalLeader>tp', ':TypstPreview<CR>')

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.typ",
  callback = function ()
    if vim.b.export_typst then
      vim.cmd[[LspTinymistExportPdf]]
    end
  end,
})

vim.api.nvim_create_user_command("AutoPdfToggle", function ()
  vim.b.export_typst = not vim.b.export_typst
  print("Set pdf export to", vim.b.export_typst)
end, {})
