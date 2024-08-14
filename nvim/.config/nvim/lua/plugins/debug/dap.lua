return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      automatic_installation = true,

      handlers = {},

      ensure_installed = {
        -- python
        "debugpy",

        -- go
        "delve",
      },
    },
  },

  {
    "mfussenegger/nvim-dap",
    recommended = true,
    desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },

  -- stylua: ignore
    keys = {
      { "<leader>dc", require("dap").continue, desc = "Start/Continue" },
      { "<leader>dp", require("dap").pause , desc = "Pause" },
      { "<leader>dr", require("dap").restart , desc = "Restart" },
      { "<leader>dp", require("dap").pause , desc = "Pause" },
      { "<leader>ds", require("dap").run_to_cursor , desc = "Run Debugger to Cursor" },
      { "<leader>dq", require("dap").close , desc = "Close Debugger Session" },
      { "<leader>dQ", require("dap").terminate , desc = "Terminate" },
      { "<leader>db", require("dap").toggle_breakpoint , desc = "Toggle Breakpoint" },
      { "<leader>dB", require("dap").clear_breakpoints , desc = "Clear Breakpoints" },
      { "<leader>do", require("dap").step_over , desc = "Step Over" },
      { "<leader>di", require("dap").step_into , desc = "Step Into" },
      { "<leader>dO", require("dap").step_out , desc = "Step Out" },
      { "<leader>dj", require("dap").down , desc = "Step Down" },
      { "<leader>dk", require("dap").up , desc = "Step Up" },
      { "<leader>dh", require("dap.ui.widgets").hover, desc = "Debugger Hover" },
    },
    config = function()
      local sign = vim.fn.sign_define
      sign("DapBreakpoint", { text = "" })
      sign("DapBreakpointCondition", { text = "", texthl = "", linehl = "", numhl = "" })
      sign("DapLogPoint", { text = "󰁕", texthl = "", linehl = "", numhl = "" })
      -- sign("DapStopped", { text = "󰛿", texthl = "", linehl = "", numhl = "" })
      sign("DapStopped", { text = "󰁕", texthl = "", linehl = "", numhl = "" })
      sign("DapBreakpointRejected", { text = "", texthl = "", linehl = "", numhl = "" })
    end,
  },
}
