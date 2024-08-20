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

    vim.api.nvim_create_autocmd("BufWinEnter", {
      pattern = "*",
      callback = function()
        -- Check if the buffer's filetype matches any of the DAP UI related filetypes
        if
          vim.tbl_contains({
            "dapui_scopes",
            "dapui_breakpoints",
            "dapui_stacks",
            "dapui_watches",
            "dap-repl",
            "dapui_console",
          }, vim.bo.filetype)
        then
          vim.wo.winfixwidth = true
          vim.wo.winbar = nil
          vim.wo.number = false
          vim.wo.foldenable = false
          vim.wo.foldcolumn = "0"
        end
      end,
    })
  end,
}
