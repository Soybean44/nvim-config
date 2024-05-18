return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "mfussenegger/nvim-dap-python",
    },
    config = function ()
      local dap = require("dap")
      local ui = require("dapui")

      require("dapui").setup()
      require("dap-python").setup "/usr/bin/python"

      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" }
      }

      dap.configurations.c = {
        {
          name = "gdb",
          type = "gdb",
          request = "launch",
          -- program = "/usr/bin/gdb",
          program = function()
            return vim.fn.input({
              prompt = "Path to Debuggable Executable: ",
              default = vim.fn.getcwd() .. '/',
              completion = "file"
            })
          end,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
          console = "integratedTerminal"
        },
      }

      dap.configurations.cpp = {
        {
          name = "gdb",
          type = "gdb",
          request = "launch",
          -- program = "/usr/bin/gdb",
          program = function()
            return vim.fn.input({
              prompt = "Path to Debuggable Executable: ",
              default = vim.fn.getcwd() .. '/',
              completion = "file"
            })
          end,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
          console = "integratedTerminal"
        },
      }

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end

      vim.keymap.set("n", "<leader>dq", dap.terminate)
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
      vim.keymap.set("n", "<leader>dr", dap.continue)

      vim.keymap.set("n", "<F1>", dap.step_into)
      vim.keymap.set("n", "<F2>", dap.step_over)
      vim.keymap.set("n", "<F3>", dap.step_out)
      vim.keymap.set("n", "<F4>", dap.step_back)
      vim.keymap.set("n", "<F9>", dap.restart)

    end
  },
}
