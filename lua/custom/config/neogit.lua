local wrap = function(func, ...)
  local args = {...}
  return function()
    func(unpack(args))
  end
end

local neogit = require("neogit")
neogit.setup{}

vim.keymap.set("n", "<leader>gs", neogit.open)
vim.keymap.set("n", "<leader>gp", wrap(neogit.open, {"push"}))
vim.keymap.set("n", "<leader>gP", wrap(neogit.open, {"pull"}))
vim.keymap.set("n", "<leader>gc", wrap(neogit.open, {"commit"}))


