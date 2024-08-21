local wk = require("which-key")

wk.add({
  { "<leader>f", group = "Telescope", icon = "" },
  { "<leader>e", icon = "󰌀" },
  { "<leader>o", icon = "󰌀" },
  { "<leader>b", group = "Buffer" },
  { "<leader>m", group = "Multicurcors", icon = "󰇀" },
  { "<leader><Tab>", group = "DBUI", icon = "󰆼" },

  { "<leader>c", icon = "✗" },
  { "<leader>C", icon = "✗" },

  { "<leader>w", desc = "Save", icon = "󰆓" },

  -- { "<leader>x", group = "Trouble", icon = "" },
})

wk.setup({
  preset = "modern",
})
