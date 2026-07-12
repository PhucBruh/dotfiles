require("mini.indentscope").setup()
require("mini.comment").setup()
require("leap").setup({})
require("origami").setup()
require("nvim-surround").setup()
require("tmux").setup({
  navigation = {
    enable_default_keybindings = false,
    persist_zoom = true,
  },
  copy_sync = {
    sync_clipboard = false,
  },
})

vim.keymap.set({ "n", "x", "o" }, "<M-h>", function()
  require("tmux").move_left()
end)
vim.keymap.set({ "n", "x", "o" }, "<M-j>", function()
  require("tmux").move_bottom()
end)
vim.keymap.set({ "n", "x", "o" }, "<M-k>", function()
  require("tmux").move_top()
end)
vim.keymap.set({ "n", "x", "o" }, "<M-l>", function()
  require("tmux").move_right()
end)

require("mini.pairs").setup()
local map_pairs = function(lhs, rhs)
  vim.keymap.set("i", lhs, rhs, { expr = true, replace_keycodes = false })
end

map_pairs("<C-h>", "v:lua.MiniPairs.bs()")
map_pairs("<C-w>", 'v:lua.MiniPairs.bs("\23")')
map_pairs("<C-u>", 'v:lua.MiniPairs.bs("\21")')

vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")

require("mini.files").setup({
  windows = {
    preview = true,
    width_focus = 30,
    width_preview = 50,
  },
  mappings = {
    go_in = "<CR>",
    go_in_plus = "l",
    go_out = "-",
    go_out_plus = "h",
  },
})

vim.keymap.set("n", "-", function()
  MiniFiles.open()
end, { desc = "Open mini.files" })
