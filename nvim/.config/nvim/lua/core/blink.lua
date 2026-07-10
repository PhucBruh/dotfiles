local blink = require("blink.cmp")

blink.build():pwait()
require("blink.cmp").setup({
  keymap = { preset = "default" },

  appearance = { nerd_font_variant = "mono" },

  completion = {
    documentation = {
      auto_show = false,
    },
    menu = {
      border = "none",
      draw = {
        padding = 1,
        gap = 1,

        columns = {
          { "kind_icon" },
          {
            "label",
            "label_description",
            gap = 1,
            width = { fill = true },
          },
          { "source_name" },
        },
      },
    },
  },

  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
})

vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "#141a22" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = "#16181a" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#2a2d31", fg = "#7bdff2" })
