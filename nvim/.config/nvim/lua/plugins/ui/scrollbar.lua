return {
  "petertriho/nvim-scrollbar",
  config = function()
    require("scrollbar").setup({
      excluded_filetypes = {
        "alpha",
        "aerial",
        "dbui",
        "dbee",
        "dbout",
        "lazy",
        "NvimTree",
        "TelescopePrompt",

        "dapui_watches",
        "dapui_scopes",
        "dapui_stacks",
        "dapui_breakpoints",
        "dapui_scopes",
        "dap-repl",
        "dapui_console",
      },

      marks = {
        Cursor = {
          text = " ",
        },
      },
    })
  end,
}
