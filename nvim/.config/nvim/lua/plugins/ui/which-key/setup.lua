local wk = require("which-key")

wk.add({
  { "<leader>f", group = "Telescope", icon = "" },
  { "<leader>m", group = "Multicurcors", icon = "󰇀" },
  { "<leader><Tab>", group = "DBUI", icon = "󰆼" },

  { "<leader>c", icon = "✗" },
  { "<leader>C", icon = "✗" },

  { "<leader>w", desc = "Save", icon = "󰆓" },
})

wk.setup({
  preset = "helix",
})
