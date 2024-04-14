local harpoon = require("harpoon")
harpoon:setup({ cmd = {} })

local new_list = harpoon:list("cmd")
vim.print(new_list.items)
