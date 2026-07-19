local map = vim.keymap.set

require("origami").setup()
require("nvim-surround").setup()
require("mini.indentscope").setup()
require("mini.comment").setup()
require("mini.pairs").setup()
local map_pairs = function(lhs, rhs)
  map("i", lhs, rhs, { expr = true, replace_keycodes = false })
end

map_pairs("<C-h>", "v:lua.MiniPairs.bs()")
map_pairs("<C-w>", 'v:lua.MiniPairs.bs("\23")')
map_pairs("<C-u>", 'v:lua.MiniPairs.bs("\21")')

local ai = require("mini.ai")

ai.setup({
  n_lines = 500,
})

require("mini.files").setup({
  windows = {
    preview = true,
    width_focus = 30,
    width_preview = 50,
  },
  mappings = {
    close = "<C-c>",
    go_in = "<C-j>",
    go_in_plus = "l",
    go_out = "-",
    go_out_plus = "h",
  },
})

vim.keymap.set("n", "_", function()
  MiniFiles.open()
end, { desc = "Open mini.files" })

require("oil").setup({
  delete_to_trash = true,
  keymaps = {
    ["<C-j>"] = "actions.select",
    ["<C-c>"] = { "actions.close", mode = "n" },
  },
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = true,
  },
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

require("leap").setup({})
require("leap").opts.preview = function(ch0, ch1, ch2)
  return not (ch1:match("%s") or (ch0:match("%a") and ch1:match("%a") and ch2:match("%a")))
end

map({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
map({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")

require("mini.diff").setup({
  view = {
    style = "sign",
    signs = { add = "│", change = "│", delete = "│" },
  },
})

map("n", "go", function()
  require("mini.diff").toggle_overlay(0)
end, { desc = "Toggle diff overlay" })

require("mini.jump").setup()
local jump_stop = function()
  if not MiniJump.state.jumping then
    return "<Esc>"
  end
  MiniJump.stop_jumping()
end
local opts = { expr = true, desc = "Stop jumping" }
map({ "n", "x", "o" }, "<C-c>", jump_stop, opts)

map("n", "<M-h>", "<cmd>TmuxNavigateLeft<CR>")
map("n", "<M-j>", "<cmd>TmuxNavigateDown<CR>")
map("n", "<M-k>", "<cmd>TmuxNavigateUp<CR>")
map("n", "<M-l>", "<cmd>TmuxNavigateRight<CR>")
