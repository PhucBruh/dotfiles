require("mini.indentscope").setup()
require("mini.comment").setup()
require("leap").setup({})
require("origami").setup()
require("nvim-surround").setup()

require("mini.pairs").setup()
local map_pairs = function(lhs, rhs)
  vim.keymap.set("i", lhs, rhs, { expr = true, replace_keycodes = false })
end

map_pairs("<C-h>", "v:lua.MiniPairs.bs()")
map_pairs("<C-w>", 'v:lua.MiniPairs.bs("\23")')
map_pairs("<C-u>", 'v:lua.MiniPairs.bs("\21")')

vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")

require("oil").setup({
  columns = {
    "icon",
  },
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ["<CR>"] = false,
    ["<C-j>"] = "actions.select",
  },
  delete_to_trash = true,
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
