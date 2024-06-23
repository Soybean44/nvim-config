return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "EvWilson/slimux.nvim" },
  config = function()
    local harpoon = require "harpoon"

    local function run_command(cmd)
      local function get_os_command_output(input_cmd, cwd)
        if type(input_cmd) ~= "table" then
          print("Harpoon: [get_os_command_output]: input_cmd has to be a table")
          return {}
        end
        local Job = require("plenary.job")
        local command = table.remove(input_cmd, 1)
        local stderr = {}
        local stdout, ret = Job
        :new({
          command = command,
          args = input_cmd,
          cwd = cwd,
          on_stderr = function(_, data)
            table.insert(stderr, data)
          end,
        })
        :sync()
        return stdout, ret, stderr
      end
      local _, ret, stderr = get_os_command_output({
        "tmux",
        "send-keys",
        "-t1",
        string.format('%s', cmd),
        ";",
        "send-keys",
        "-t1",
        "Enter",
        ";",
        "select-window",
        "-t1",
      }, vim.loop.cwd())
      print(string.format('sending command: %s', harpoon:list("cmd"):get(1).value))
      if ret ~= 0 then
        if stderr then
          error("Failed to send command. " .. stderr[1])
        end
      end
    end

    harpoon:setup({
      settings = {
        sync_on_ui_close = true,
      },
      ["cmd"] = {
        select = function(list_item, list, option)
          run_command(list_item.value)
        end
      },
    })


    vim.keymap.set("n", "<leader>a", function()
      harpoon:list("files"):add()
    end)
    vim.api.nvim_create_user_command("ClearCompileCommands", function()
      harpoon:list("cmd"):clear()
    end, {})
    vim.api.nvim_create_user_command("CompileModeCommand", function(opts)
      print(string.format("Adding command: %s", opts.args))
      harpoon:list("cmd"):prepend({value = opts.args})
    end, { nargs='?' })
    vim.keymap.set("n", "<C-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list("files"))
    end)
    vim.keymap.set("n", "<M-c>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list("cmd"))
    end)

    vim.keymap.set("n", "<M-j>", function()
      harpoon:list("files"):select(1)
    end)
    vim.keymap.set("n", "<M-f>", function()
      harpoon:list("files"):select(2)
    end)
    vim.keymap.set("n", "<M-k>", function()
      harpoon:list("files"):select(3)
    end)
    vim.keymap.set("n", "<M-d>", function()
      harpoon:list("files"):select(4)
    end)
    vim.keymap.set("n", "<M-r>", function()
      run_command(harpoon:list("cmd"):get(1).value)
    end)
  end,
}

