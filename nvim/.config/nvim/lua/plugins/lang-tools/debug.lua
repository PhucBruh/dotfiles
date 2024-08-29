local map = vim.keymap.set
local sign = vim.fn.sign_define
local set_hl = vim.api.nvim_set_hl

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "rcarriga/nvim-dap-ui",
  },
  config = function()
    require("dapui").setup()
    require("nvim-dap-virtual-text").setup({})

    map("n", "<leader>du", require("dapui").toggle, { desc = "Debugger Toggle" })
    map("n", "<leader>de", require("dapui").eval, { desc = "Evaluate Input" })

    map("n", "<leader>dc", require("dap").continue, { desc = "Start/Continue" })
    map("n", "<leader>dp", require("dap").pause, { desc = "Pause" })
    map("n", "<leader>dr", require("dap").restart, { desc = "Restart" })
    map("n", "<leader>dp", require("dap").pause, { desc = "Pause" })
    map("n", "<leader>ds", require("dap").run_to_cursor, { desc = "Run Debugger to Cursor" })
    map("n", "<leader>dq", require("dap").close, { desc = "Close Debugger Session" })
    map("n", "<leader>dQ", require("dap").terminate, { desc = "Terminate" })
    map("n", "<leader>db", require("dap").toggle_breakpoint, { desc = "Toggle Breakpoint" })
    map("n", "<leader>dB", require("dap").clear_breakpoints, { desc = "Clear Breakpoints" })
    map("n", "<leader>do", require("dap").step_over, { desc = "Step Over" })
    map("n", "<leader>di", require("dap").step_into, { desc = "Step Into" })
    map("n", "<leader>dO", require("dap").step_out, { desc = "Step Out" })
    map("n", "<leader>dj", require("dap").down, { desc = "Step Down" })
    map("n", "<leader>dk", require("dap").up, { desc = "Step Up" })
    map("n", "<leader>dh", require("dap.ui.widgets").hover, { desc = "Debugger Hover" })

    set_hl(0, "db_blue", { fg = "#3d59a1" })
    set_hl(0, "db_green", { fg = "#9ece6a" })
    set_hl(0, "db_yellow", { fg = "#FFFF00" })
    set_hl(0, "db_orange", { fg = "#f09000" })

    sign("DapBreakpoint", { text = "", texthl = "db_blue" })
    sign("DapBreakpointCondition", { text = "", texthl = "db_blue" })
    sign("DapBreakpointRejected", { text = "", texthl = "db_orange" })
    sign("DapStopped", { text = "󰁕", texthl = "db_green" })
    sign("DapLogPoint", { text = "󰛿", texthl = "db_yellow" })
  end,
}
