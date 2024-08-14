local wk = require("which-key")

wk.add({
  { "<leader>f", group = "Telescope" }, -- group
})

wk.setup({
  preset = "helix",
})
