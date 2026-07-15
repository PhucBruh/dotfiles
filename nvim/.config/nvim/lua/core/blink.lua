local blink = require("blink.cmp")

blink.build():pwait()
require("blink.cmp").setup({
  keymap = { preset = "default" },

  appearance = { nerd_font_variant = "mono" },

  completion = {
    documentation = {
      window = {
        border = "single",
      },
      auto_show = false,
    },
    menu = {
      border = "single",
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
    per_filetype = {
      markdown = { "lsp", "path", "buffer" },
    },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
})
