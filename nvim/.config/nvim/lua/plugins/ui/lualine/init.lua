return {
  "nvim-lualine/lualine.nvim",
  event = { "BufRead", "WinLeave" },
  config = function()
    require("plugins.ui.lualine.setup")
  end,
}
