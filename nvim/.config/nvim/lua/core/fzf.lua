local map = vim.keymap.set

require("fzf-lua").setup({
  winopts = {
    border = "single",
    width = 0.8,
    height = 0.9,
    preview = {
      border = "single",
      layout = "vertical",
      vertical = "up:60%",
    },
  },

  file_ignore_patterns = {
    "^%.git/",
    "node_modules/",
    "__pycache__/",
    "venv/",
    "%.venv/",
    "%.pyc$",
    "%.pyo$",
    "target/",
    "dist/",
    "build/",
    ".cache/",
    "%.o$",
    "%.so$",
    "vendor/",
    "coverage/",
    "%.min.js$",
    "%.min.css$",
    ".DS_Store",
  },
  keymap = {
    builtin = {
      ["<C-d>"] = "preview-page-down",
      ["<C-u>"] = "preview-page-up",
    },
    fzf = {
      ["ctrl-j"] = "accept",
    },
  },
})

map("n", "<leader>fc", function()
  require("fzf-lua").files({
    cwd = vim.fn.stdpath("config"),
    prompt = "Nvim Config❯ ",
  })
end, { desc = "Neovim Config Files" })

-- stylua: ignore start
map("n", "<leader><space>", "<cmd>FzfLua<cr>",                  { desc = "FzfLua" })
map("n", "<leader>fi", "<cmd>FzfLua files<cr>",                 { desc = "Files" })
map("n", "<leader>fj", "<cmd>FzfLua buffers<cr>",               { desc = "Buffers" })
map("n", "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>",  { desc = "Diagnostics Document" })
map("n", "<leader>fD", "<cmd>FzfLua diagnostics_workspace<cr>", { desc = "Diagnostics Workspace" })
map("n", "<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>",  { desc = "Document Symbols" })
map("n", "<leader>fS", "<cmd>FzfLua lsp_workspace_symbols<cr>", { desc = "Workspace Symbols" })
map("n", "<leader>fo", "<cmd>FzfLua resume<cr>",                { desc = "Resume fzf" })
map("n", "<leader>fh", "<cmd>FzfLua oldfiles<cr>",              { desc = "Old files" })
map("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>",             { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>FzfLua grep_curbuf<cr>",           { desc = "Grep Current Buffers" })
map("n", "<leader>fw", "<cmd>FzfLua grep_cword<cr>",            { desc = "Grep word" })
map("n", "<leader>fW", "<cmd>FzfLua grep_cWORD<cr>",            { desc = "Grep WORD" })

local Previewer = require("fzf-lua.previewer.builtin").base:extend()
function Previewer:new(o, opts, w) Previewer.super.new(self, o, opts, w); return setmetatable(self, Previewer) end
function Previewer:populate_preview_buf(s)
  local buf = self:get_tmp_buffer()
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(self.full[s:match("^%[(%d+)%]")] or s, "\n"))
  vim.bo[buf].filetype = "markdown"
  self:set_preview_buf(buf)
end

map("n", "<leader>fn", function()
  local h = require("fidget.notification").get_history()
  if #h == 0 then return vim.notify("No notifications") end

  local full, items = {}, {}
  for i, e in ipairs(h) do
    items[i] = ("[%d] %s %s"):format(i, e.annote or "", (e.message or ""):gsub("\n", " "))
    full[tostring(i)] = ("# %s\n\n%s"):format(e.annote or "", e.message or "")
  end

  Previewer.full = full
  require("fzf-lua").fzf_exec(items, { previewer = Previewer , winopts = { title = " Notifications " }})
end, { desc = "Notifications (fidget)" })
-- stylua: ignore end
