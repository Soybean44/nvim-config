--------------------------------------------
-- All web related items in a modular file.
-- This file is completely optional
--------------------------------------------

-- Typescript / Javascript
vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  root_markers = { "package.json", "tsconfig.json", ".git" },
  filetypes = {
    "javascript", "javascriptreact",
    "typescript", "typescriptreact",
  },
})
vim.lsp.enable("ts_ls")

-- HTML
vim.lsp.config("html", {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html", "htm" },
})
vim.lsp.enable("html")

-- Tailwind CSS
vim.lsp.config("tailwindcss", {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "html", "css",
    "javascriptreact", "typescriptreact",
  },
  root_markers = {
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.ts",
    "postcss.config.js",
    "package.json",
  },
})
vim.lsp.enable("tailwindcss")

-- Emmet (HTML / JSX / TSX)
vim.lsp.config("emmet_ls", {
  cmd = { "emmet-language-server", "--stdio" },
  filetypes = {
    "html", "css",
    "javascript", "javascriptreact",
    "typescript", "typescriptreact",
  },
  init_options = {
    jsx = { options = { ["enabled"] = true } },
  },
})
vim.lsp.enable("emmet_ls")
