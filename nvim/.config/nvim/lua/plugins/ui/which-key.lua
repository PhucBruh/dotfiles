return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function()
    local wk = require("which-key")

    wk.add({
      { "<leader>f", group = "Telescope", icon = "" },
      { "<leader>e", icon = "󰌀" },
      { "<leader>b", group = "Buffer" },
      { "<leader>ud", icon = "󰆼" },

      { "<leader>c", icon = "✗" },
      { "<leader>C", icon = "✗" },

      { "<leader>w", desc = "Save", icon = "󰆓" },

      -- { "<leader>x", group = "Trouble", icon = "" },
    })

    wk.setup({
      preset = "helix",
    })
  end,
}
