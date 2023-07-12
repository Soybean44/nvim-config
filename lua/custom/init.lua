vim.wo.relativenumber = true
vim.cmd[[
  let &shell = has('win32') ? 'powershell' : 'pwsh'
  set shellquote= shellpipe=\| shellxquote=
  set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
  set shellredir=\|\ Out-File\ -Encoding\ UTF8
]]
