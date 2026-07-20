require("cyberdream").setup({
  colors = {
    dark = {
      bg = "#16161e",
      bg_alt = "#1f2335",
      bg_highlight = "#292e42",
      fg = "#c0caf5",
      blue = "#89b4fa",
      cyan = "#7dcfff",
      grey = "#565f89",
    },
  },
  overrides = function(c)
    local border = { fg = c.blue }
    return {
      FloatBorder = border,

      MiniFilesBorder = border,
      MiniFilesBorderModified = border,

      BlinkCmpMenuBorder = border,

      CursorLineNr = { fg = c.cyan },

      MarkviewYmlIcon = { fg = c.orange },
      MarkviewYmlKey = { fg = c.blue, bold = true },
      MarkviewYmlTitle = { fg = c.cyan, bold = true },
      MarkviewYmlScalar = { fg = c.fg },
      MarkviewYmlDate = { fg = c.green, bold = true },
      MarkviewYmlBoolean = { fg = c.fg },
      MarkviewYmlNumber = { fg = c.fg },
      MarkviewYmlList = { fg = c.magenta },
      MarkviewYmlEmpty = { fg = c.fg },
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
  { "<leader>d", group = "Debug" },
  { "g", group = "Goto / LSP" },
  { "z", group = "Folds" },
})

vim.keymap.set("n", "<leader>?", function()
  wk.show({ global = false })
end, {
  desc = "Buffer Keymaps",
})
