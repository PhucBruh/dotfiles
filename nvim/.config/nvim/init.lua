vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("config.pack")
require("config.keymaps")
require("config.autocmds")

require("core")
require("editor")
require("lang")
require("tools")
require("ui")
