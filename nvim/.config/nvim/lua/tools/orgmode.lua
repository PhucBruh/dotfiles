local org_dir = vim.fn.expand("~/Documents/org/")
local Menu = require("org-modern.menu")

require("orgmode").setup({
  org_agenda_files = {
    org_dir .. "/**/*",
  },

  org_default_notes_file = org_dir .. "inbox.org",

  org_todo_keywords = {
    "TODO",
    "NEXT",
    "WAIT",
    "|",
    "DONE",
    "CANCELLED",
  },

  ui = {
    menu = {
      handler = function(data)
        Menu:new({
          window = {
            margin = { 1, 0, 1, 0 },
            padding = { 0, 1, 0, 1 },
            title_pos = "center",
            border = "none",
            zindex = 1000,
          },
          icons = {
            separator = "➜ ",
          },
        }):open(data)
      end,
    },
  },
})

vim.lsp.enable("org")

require("org-roam").setup({
  directory = org_dir,
})

require("org-bullets").setup({
  concealcursor = true,
  symbols = {
    list = "•",
    headlines = { "◉", "○", "✸", "✿" },
  },
})
