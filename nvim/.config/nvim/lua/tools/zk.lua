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
local notes = os.getenv("ZK_NOTEBOOK_DIR") or (os.getenv("HOME") .. "/notes")

-- <leader>nf — Navigate (open things)
map("n", "<leader>zi", "<cmd>e " .. notes .. "/inbox.md<cr>", { desc = "Inbox" })
map("n", "<leader>zj", function()
  local date = os.date("%Y-%m-%d")
  vim.cmd("e " .. notes .. "/journal/" .. date .. ".md")
end, { desc = "Today's Journal" })

-- stylua: ignore start
map("n", "<leader>zJ", "<cmd>FzfLua files cwd=" .. notes .. "/journal prompt='Journal❯ '<CR>", { desc = "Journal" })
map("n","<leader>zp",  "<cmd>FzfLua files cwd=" .. notes .. "/projects prompt='Projects❯ '<CR>",  { desc = "Projects" })

-- create
map("n", "<leader>zn", "<cmd>ZkNew { dir = 'zk/permanent' }<CR>", { desc = "zk/new permanent" })
map("n", "<leader>zN", "<cmd>ZkNew { dir = 'zk/literature' }<CR>", { desc = "zk/new literature" })

-- find
map("n", "<leader>zf", "<cmd>ZkNotes<CR>", { desc = "zk/find" })
map("n", "<leader>zr", "<cmd>ZkNotes { sort = { 'modified' }, createdAfter = 'last two weeks' }<CR>", { desc = "zk/recent" })
map("n", "<leader>zt", "<cmd>ZkTags<CR>", { desc = "zk/tags" })
map("n", "<leader>zb", "<cmd>ZkBacklinks<CR>", { desc = "zk/backlinks" })
map("n", "<leader>zl", "<cmd>ZkLinks<CR>", { desc = "zk/links" })
map("n", "<leader>zL", "<cmd>ZkInsertLink<CR>", { desc = "zk/insert link" })
map("n", "<leader>zo", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "zk/open link" })
-- stylua: ignore end

map("n", "<leader>zs", function()
  local dir = notes
  vim.system(
    { "sh", "-c", "cd " .. dir .. " && git add . && git commit -m 'update " .. os.date("%Y-%m-%d") .. "' && git push" },
    { text = true },
    function(out)
      vim.schedule(function()
        if out.code == 0 then
          vim.notify("Notes synced", vim.log.levels.INFO)
        else
          vim.notify("Sync failed: " .. (out.stderr or ""), vim.log.levels.ERROR)
        end
      end)
    end
  )
end, { desc = "zk/sync" })
