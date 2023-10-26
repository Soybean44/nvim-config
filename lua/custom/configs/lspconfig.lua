local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")
local servers = { "clangd", "pyright" }

for i = 1, #servers do
  lspconfig[servers[i]].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
