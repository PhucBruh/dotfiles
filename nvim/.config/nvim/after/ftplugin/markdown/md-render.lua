vim.opt_local.conceallevel = 2
vim.opt_local.concealcursor = "nc"

require("markdown-plus").setup({})
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { buffer = true, desc = "Next buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { buffer = true, desc = "Previous buffer" })

local yml = require("after.ftplugin.markdown.md-yml")

require("render-markdown").setup({
  file_types = { "markdown" },
  latex = { enabled = false },
  preset = "obsidian",
  heading = {
    icons = { "󰼏  ", "󰼐  ", "󰼑  ", "󰼒  ", "󰼓  ", "󰼔  ", "󰼕  " },
    position = "inline",
    width = "block",
    right_pad = 1,
    left_pad = 1,
    sign = false,
  },
  bullet = { icons = { "•" } },
  checkbox = {
    unchecked = { icon = "󰄱 " },
    checked = { icon = "󰱒 " },
  },
  code = {
    width = "block",
    language_pad = 1,
  },
  yaml = { enabled = false },
  custom_handlers = {
    yaml = { parse = yml.parse, extends = false },
  },
})
require("render_latex").setup({})
