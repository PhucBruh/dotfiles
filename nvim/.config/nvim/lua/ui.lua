require("cyberdream").setup({
  overrides = function()
    local border = { fg = "#7aa2f7", bg = "NONE" }
    return {
      FloatBorder = border,

      MiniFilesBorder = border,
      MiniFilesBorderModified = border,

      BlinkCmpMenuBorder = border,
      BlinkCmpMenuSelection = { bg = "#2a2d31", fg = "#7bdff2" },
      BlinkCmpSignatureHelp = { fg = "#16181a", bg = "#16181a" },

      CursorLine = { bg = "#253547" },
      Visual = { bg = "#3a4b61" },
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
