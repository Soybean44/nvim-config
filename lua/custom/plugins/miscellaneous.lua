return {
  {
    'vimwiki/vimwiki',
    lazy = false,
    init = function()
      vim.g.vimwiki_folding = 'custom'
      vim.g.markdown_folding = 1
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "vimwiki",
        callback = function()
          vim.opt_local.filetype = "markdown"
        end,
      })
      vim.g.vimwiki_list = {
        {
          path = '~/syncthing/notes',
          syntax = 'markdown',
          ext = 'md',
          index = 'index',
          default = 1,
        }
      }
      vim.keymap.set("n", "<leader>gl", ":VimwikiNextLink<CR>:VimwikiFollowLink<CR>")
    end
  },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      image = {
        env = {
          SNACKS_GHOSTTY = true
        },
        doc = {
          -- enable image viewer for documents
          -- a treesitter parser must be available for the enabled languages.
          enabled = true,
          -- render the image inline in the buffer
          -- if your env doesn't support unicode placeholders, this will be disabled
          -- takes precedence over `opts.float` on supported terminals
          inline = true,
          -- render the image in a floating window
          -- only used if `opts.inline` is disabled
          float = true,
          max_width = 80,
          max_height = 40,
          -- Set to `true`, to conceal the image text when rendering inline.
          -- (experimental)
          ---@param lang string tree-sitter language
          ---@param type snacks.image.Type image type
          conceal = function(lang, type)
            -- only conceal math expressions
            return type == "math"
          end,
        },
      },
      convert = {
        notify = true, -- show a notification on error
        ---@type snacks.image.args
        mermaid = function()
          local theme = vim.o.background == "light" and "neutral" or "dark"
          return { "-i", "{src}", "-o", "{file}", "-b", "transparent", "-t", theme, "-s", "{scale}" }
        end,
        ---@type table<string,snacks.image.args>
        magick = {
          default = { "{src}[0]", "-scale", "1920x1080>" }, -- default for raster images
          vector = { "-density", 193, "{src}[0]" },         -- used by vector images like svg
          math = { "-density", 192, "{src}[0]", "-trim" },
          pdf = { "-density", 192, "{src}[0]", "-background", "white", "-alpha", "remove", "-trim" },
        },
      },
      math = {
        enabled = true, -- enable math expression rendering
        -- in the templates below, `${header}` comes from any section in your document,
        -- between a start/end header comment. Comment syntax is language-specific.
        -- * start comment: `// snacks: header start`
        -- * end comment:   `// snacks: header end`
        typst = {
          tpl = [[
          #set page(width: auto, height: auto, margin: (x: 2pt, y: 2pt))
          #show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
          #set text(size: 12pt, fill: rgb("${color}"))
          ${header}
          ${content}]],
        },
        latex = {
          font_size = "Large", -- see https://www.sascha-frank.com/latex-font-size.html
          -- for latex documents, the doc packages are included automatically,
          -- but you can add more packages here. Useful for markdown documents.
          packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" },
          tpl = [[
          \documentclass[preview,border=0pt,varwidth,12pt]{standalone}
          \usepackage{${packages}}
          \begin{document}
          ${header}
          { \${font_size} \selectfont
          \color[HTML]{${color}}
          ${content}}
          \end{document}]],
        },
      },
    }
  },
  'ThePrimeagen/vim-be-good',
}
