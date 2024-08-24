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

        -- rust
        "codelldb",

        -- js
        "js-debug-adapter",
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
      { "<leader>d", "", desc = "Debug" },
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
      local set_hl = vim.api.nvim_set_hl
      set_hl(0, "db_blue", { fg = "#3d59a1" })
      set_hl(0, "db_green", { fg = "#9ece6a" })
      set_hl(0, "db_yellow", { fg = "#FFFF00" })
      set_hl(0, "db_orange", { fg = "#f09000" })

      -- stylua: ignore start
      local sign = vim.fn.sign_define
      sign('DapBreakpoint',          { text='', texthl='db_blue'})
      sign('DapBreakpointCondition', { text='', texthl='db_blue'})
      sign('DapBreakpointRejected',  { text='', texthl='db_orange'})
      sign('DapStopped',             { text='󰁕', texthl='db_green'})
      sign('DapLogPoint',            { text='󰛿', texthl='db_yellow'})
      -- stylua: ignore end
    end,
  },
}
