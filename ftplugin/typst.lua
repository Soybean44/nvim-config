if vim.treesitter.language.add('typst') then
  vim.treesitter.start(bufnr, 'typst')
end

vim.g.maplocalleader = ","
vim.g.export_typst = true
vim.keymap.set('n', '<LocalLeader>tp', ':TypstPreview<CR>')

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.typ",
  callback = function ()
    if vim.g.export_typst then
      vim.cmd[[LspTinymistExportPdf]]
    end
  end,
})

local export_types = { "pdf", "png", "svg", "html" }

local function export(args)
  local target
  if vim.tbl_contains(export_types, args[1]) then
    target = args[1]
  elseif args[1] == nil then
    target = "pdf"
  else
    print("Unsupported filetype. Use 'pdf' or 'png'.")
    return
  end
  local filetype = vim.bo.filetype
  if filetype ~= "typst" then
    print("Current buffer is not a typst file")
    return
  end
  local current_file = vim.fn.expand("%:p:r")
  local output_file = current_file .. "." .. target
  if target ~= "pdf" then
    output_file = current_file .. "_{p}." .. target
  end
  local cmd = "typst compile --format " .. target .. " " .. current_file .. ".typ " .. output_file
  print("Running: " .. cmd)
  local result = vim.fn.system(cmd)
  local exit_code = vim.v.shell_error
  if exit_code ~= 0 then
    print("Typst compilation failed: " .. result)
  else
    print("Successfully exported to " .. target)
  end
end

vim.api.nvim_create_user_command("TypstExport", export, {
  nargs = "?",
  complete = function()
    return export_types
  end
})

vim.api.nvim_create_user_command("AutoPdfToggle", function ()
  vim.g.export_typst = not vim.g.export_typst
  print("Set pdf export to", vim.g.export_typst)
end, {})

