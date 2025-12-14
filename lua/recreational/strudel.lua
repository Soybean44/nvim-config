----------------------------------
--- Strudel.nvim Configuration
----------------------------------

vim.pack.add({"https://github.com/gruvw/strudel.nvim"})

local function npm_ci_in_plugin(plugin_name)
  -- Find the directory on 'runtimepath' that contains this plugin
  local rtp = vim.api.nvim_list_runtime_paths()  -- returns a Lua table [web:12]
  local plugin_dir = nil

  for _, path in ipairs(rtp) do
    -- Adjust this pattern to match how your plugin is installed
    if path:match(plugin_name) then
      plugin_dir = path
      break
    end
  end

  if not plugin_dir then
    vim.notify("Plugin '" .. plugin_name .. "' not found in runtimepath", vim.log.levels.ERROR)
    return
  end

  -- Run `npm ci` in that directory
  local cmd = "cd " .. vim.fn.shellescape(plugin_dir) .. " && npm ci"
  local output = vim.fn.system(cmd)               -- run shell command [web:17]
  local code = vim.v.shell_error                  -- exit code [web:17]

  if code ~= 0 then
    vim.notify("npm ci failed in " .. plugin_dir .. ":\n" .. output, vim.log.levels.ERROR)
  else
    vim.notify("npm ci completed in " .. plugin_dir, vim.log.levels.INFO)
  end
end

-- Run This install command once after installing the plugin
-- If there is an error with puppeteer
vim.api.nvim_create_user_command("StrudelInstall", function()
  npm_ci_in_plugin("strudel.nvim")
end, {})

local strudel = require("strudel")
strudel.setup({
  update_on_save = true,
  sync_cursor = true,
  report_ecal_errors = true
})

vim.keymap.set("n", "<leader>sl", strudel.launch, { desc = "Launch Strudel" })
vim.keymap.set("n", "<leader>sq", strudel.quit, { desc = "Quit Strudel" })
vim.keymap.set("n", "<leader>st", strudel.toggle, { desc = "Strudel Toggle Play/Stop" })
vim.keymap.set("n", "<leader>su", strudel.update, { desc = "Strudel Update" })
vim.keymap.set("n", "<leader>ss", strudel.stop, { desc = "Strudel Stop Playback" })
vim.keymap.set("n", "<leader>sb", strudel.set_buffer, { desc = "Strudel set current buffer" })
vim.keymap.set("n", "<leader>sx", strudel.execute, { desc = "Strudel set current buffer and update" })
