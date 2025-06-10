return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      local dap = require("dap")
      local ui = require("dapui")

      require("dapui").setup()
      require("dap-python").setup "/usr/bin/python"

      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = {
          "--interpreter=dap",
          "--eval-command", "set print pretty on",
        },
        options = {
          cwd = vim.fn.getcwd()
        }
      }

      dap.adapters.codelldb = {
        type = "executable",
        command = "codelldb",
      }

      dap.configurations.c = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = false,
          console = "integratedTerminal"
        },
      }

      dap.configurations.cpp = dap.configurations.c

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

      vim.keymap.set("n", "<leader>dq", ":DapTerminate<CR>")
      vim.keymap.set("n", "<leader>db", ":DapToggleBreakpoint<CR>")
      vim.keymap.set("n", "<leader>dr", ":DapContinue<CR>")

      vim.keymap.set("n", "<F1>", ":DapStepInto<CR>")
      vim.keymap.set("n", "<F2>", ":DapStepOver<CR>")
      vim.keymap.set("n", "<F3>", ":DapStepOut<CR>")
      vim.keymap.set("n", "<F4>", ":DapStepBack<CR>")
      vim.keymap.set("n", "<F9>", ":DapRestart<CR>")
    end
  },
  {
    'Weissle/persistent-breakpoints.nvim',
    dependencies = "mfussenegger/nvim-dap",
    init = function()
      require('persistent-breakpoints').setup {
        load_breakpoints_event = { "BufReadPost" }
      }
      vim.keymap.set("n", "<leader>db", ":PBToggleBreakpoint<CR>")
    end
  },
}
