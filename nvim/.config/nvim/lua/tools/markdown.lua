require("markdown-plus").setup({})
local presets = require("markview.presets")

require("markview").setup({
  markdown = {
    headings = {
      shift_width = 0,
      heading_1 = {
        style = "label",
        padding_left = " ",
        padding_right = " ",
        icon = "󰼏  ",
      },
      heading_2 = {
        style = "label",
        padding_left = " ",
        padding_right = " ",
        icon = "󰎨  ",
      },
      heading_3 = {
        style = "label",
        padding_left = " ",
        padding_right = " ",
        icon = "󰼑  ",
      },
      heading_4 = {
        style = "label",
        padding_left = " ",
        padding_right = " ",
        icon = "󰎲  ",
      },
      heading_5 = {
        style = "label",
        padding_left = " ",
        padding_right = " ",
        icon = "󰼓  ",
      },
      heading_6 = {
        style = "label",
        padding_left = " ",
        padding_right = " ",
        icon = "󰎴  ",
      },
    },
    tables = presets.tables.single,
    block_quotes = presets.block_quotes.obsidian,
  },
  preview = {
    hybrid_modes = { "n" },
  },

  latex = { enable = false },
  typst = { enable = false },
})
