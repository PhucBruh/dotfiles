vim.cmd.colorscheme("cyberdream")

require("mini.icons").setup()
require("mini.statusline").setup()

require("gitsigns").setup({
  -- stylua: ignore start
  signs = {
    add          = { text = "│" },
    change       = { text = "│" },
    delete       = { text = "_" },
    topdelete    = { text = "‾" },
    changedelete = { text = "~" },
    untracked    = { text = "┆" },
  },
  -- stylua: ignore end
})

local wk = require("which-key")

wk.setup({

  preset = "helix",

  win = {
    border = "none",
    padding = { 1, 2 },
    title = false,
  },

  layout = {
    width = {
      min = 20,
      max = 35,
    },
    spacing = 2,
  },

  icons = {
    mappings = true,
    separator = "→",
  },

  keys = {
    scroll_down = "<C-d>",
    scroll_up = "<C-u>",
  },
})

wk.add({
  { "<leader>?", group = "Buf keymap", icon = "" },
  { "<leader>f", group = "Find",       icon = "" },
  { "g",           group = "Goto / LSP", icon = "󰌒" },
  { "z",           group = "Folds",     icon = "" },
})

vim.keymap.set("n", "<leader>?", function()
  wk.show({ global = false })
end, {
  desc = "Buffer Keymaps",
})

vim.api.nvim_set_hl(0, "CursorLine", { bg = "#253547" })
vim.api.nvim_set_hl(0, "Visual", { bg = "#3a4b61" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", { fg = "#16181a", bg = "#5ef1ff", bold = true })
vim.api.nvim_set_hl(0, "MiniStatuslineModeOther", { fg = "#16181a", bg = "#5ea1ff", bold = true })
