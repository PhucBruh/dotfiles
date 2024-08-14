return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "mfussenegger/nvim-dap",
    "theHamsta/nvim-dap-virtual-text",
  },
  keys = {
    { "<leader>du", require("dapui").toggle, desc = "Debugger Toggle" },
    { "<leader>de", require("dapui").eval, desc = "Evaluate Input" },
  },
  config = function()
    require("dapui").setup()
    require("nvim-dap-virtual-text").setup({})
  end,
}
