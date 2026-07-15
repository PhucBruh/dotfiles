require("zk").setup({
  picker = "fzf_lua",
  lsp = {
    config = {
      name = "zk",
      cmd = { "zk", "lsp" },
      filetypes = { "markdown" },
    },
    auto_attach = { enabled = true },
  },
})

local map = vim.keymap.set
local notes = os.getenv("NOTES") or (os.getenv("HOME") .. "/notes")

-- <leader>nf — Navigate (open things)
map("n", "<leader>zi", "<cmd>e " .. notes .. "/inbox.md<cr>", { desc = "Inbox" })
map("n", "<leader>zj", function()
  local date = os.date("%Y-%m-%d")
  vim.cmd("e " .. notes .. "/journal/" .. date .. ".md")
end, { desc = "Today's Journal" })

-- stylua: ignore start
map("n", "<leader>zJ", "<cmd>FzfLua files cwd=" .. notes .. "/journal prompt='Journal❯ '<CR>", { desc = "Journal" })
map("n","<leader>zp",  "<cmd>FzfLua files cwd=" .. notes .. "/projects prompt='Projects❯ '<CR>",  { desc = "Projects" })
-- stylua: ignore end

map("n", "<leader>zI", "<cmd>e " .. notes .. "/zk/index.md<CR>", { desc = "zk/index" })

-- create
map("n", "<leader>zn", "<cmd>ZkNew { dir = 'permanent' }<CR>", { desc = "zk/new permanent" })
map("n", "<leader>zN", "<cmd>ZkNew { dir = 'literature' }<CR>", { desc = "zk/new literature" })

-- find
map("n", "<leader>zf", "<cmd>ZkNotes<CR>", { desc = "zk/find" })
map("n", "<leader>zt", "<cmd>ZkTags<CR>", { desc = "zk/tags" })
map("n", "<leader>zb", "<cmd>ZkBacklinks<CR>", { desc = "zk/backlinks" })
map("n", "<leader>zl", "<cmd>ZkLinks<CR>", { desc = "zk/links" })
