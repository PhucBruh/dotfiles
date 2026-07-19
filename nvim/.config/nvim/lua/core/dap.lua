local dap = require("dap")
local dapview = require("dap-view")
local fzf = require("fzf-lua")
local map = vim.keymap.set

dapview.setup({})

-- operation
-- stylua: ignore start
map("n", "<leader>dc", dap.continue,              { desc = "Continue/Start" })
map("n", "<leader>do", dap.step_over,             { desc = "Step Over" })
map("n", "<leader>di", dap.step_into,             { desc = "Step Into" })
map("n", "<leader>dO", dap.step_out,              { desc = "Step Out" })
map("n", "<leader>dr", dap.run_to_cursor,         { desc = "Run to Cursor" })
map("n", "<leader>dt", dap.terminate,             { desc = "Terminate" })
map("n", "<leader>dR", dap.restart,               { desc = "Restart" })
map("n", "<leader>db", dap.toggle_breakpoint,     { desc = "Toggle Breakpoint" })
map("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Condition: "))
end,                                              { desc = "Conditional Breakpoint" })
map("n", "<leader>dx", dap.clear_breakpoints,     { desc = "Clear Breakpoint" })
map("n", "<leader>df", fzf.dap_configurations,    { desc = "Pick Config" })
map("n", "<leader>dp", fzf.dap_breakpoints,       { desc = "List Breakpoints" })
map("n", "<leader>dv", dapview.toggle,            { desc = "View" })
map({ "n", "v" }, "<leader>bw", dapview.add_expr, { desc = "Watch" })
-- stylua: ignore end
