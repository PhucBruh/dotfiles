require("cyberdream").setup({
  italic_comments = true,
  colors = {
    dark = {
      bg = "#16161E",
      bg_alt = "#1F2335",
      bg_highlight = "#292E42",
      fg = "#C0CAF5",
      blue = "#7AA2F7",
    },
  },
  overrides = function(c)
    local border = { fg = c.blue }
    return {
      FloatBorder = border,

      MiniFilesBorder = border,
      MiniFilesBorderModified = border,

      BlinkCmpMenuBorder = border,
    }
  end,
})

vim.cmd.colorscheme("cyberdream")

require("fidget").setup({
  notification = {
    override_vim_notify = true,
  },
})
require("mini.icons").setup()
require("mini.statusline").setup()

local wk = require("which-key")

wk.setup({

  preset = "helix",

  triggers = {
    { "<auto>", mode = "nxso" },
    { "m", mode = "n" },
  },

  win = {
    border = "single",
  },

  layout = {
    width = {
      min = 20,
      max = 35,
    },
    spacing = 2,
  },

  icons = {
    mappings = false,
    separator = "",
  },

  keys = {
    scroll_down = "<C-d>",
    scroll_up = "<C-u>",
  },
})

wk.add({
  { "<leader>?", group = "Buf keymap" },
  { "<leader>f", group = "Find" },
  { "<leader>g", group = "Git" },
  { "<leader>z", group = "Notes" },
  { "<leader>nf", group = "Navigate" },
  { "g", group = "Goto / LSP" },
  { "z", group = "Folds" },
})

vim.keymap.set("n", "<leader>?", function()
  wk.show({ global = false })
end, {
  desc = "Buffer Keymaps",
})
