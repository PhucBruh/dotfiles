local map = vim.keymap.set

local function open_float(lines, title)
  if #lines == 0 then
    return
  end
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  local w = math.max(#title - 2, 1) -- minimum = title length
  for _, l in ipairs(lines) do
    w = math.max(w, #l)
  end
  local width = math.min(w + 2, math.floor(vim.o.columns * 0.95))
  local height = math.min(#lines, math.floor(vim.o.lines * 0.8))
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    style = "minimal",
    border = "rounded",
    title = title,
    title_pos = "center",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
  })
  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true })
  vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = buf, silent = true })
  vim.api.nvim_create_autocmd("WinLeave", {
    buffer = buf,
    once = true,
    callback = function()
      pcall(vim.api.nvim_buf_delete, buf, { force = true })
    end,
  })
  return buf
end

local function show_messages()
  local lines = vim.tbl_filter(function(l)
    return l ~= ""
  end, vim.split(vim.fn.execute("messages"), "\n", { plain = true }))
  if #lines == 0 then
    return vim.notify("No messages")
  end
  local buf = open_float(lines, " Messages ")
  if buf then
    vim.cmd("normal! G")
  end
end

local function show_tree()
  local cmd = vim.fn.executable("tree") == 1 and "tree --noreport" or "find . | sort"
  open_float(vim.fn.systemlist(cmd), " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. " ")
end

vim.api.nvim_set_hl(0, "MyFzfBorder", {
  fg = "#7aa2f7",
  bg = "NONE",
})

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
  hls = {
    border = "MyFzfBorder",
    preview_border = "MyFzfBorder",
  },

  file_ignore_patterns = {
    "^%.git/",
    "venv/",
    "__pycache__/",
    "node_modules/",
    "%.pyc$",
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
map("n", "<leader>fi", "<cmd>FzfLua files<cr>",                 { desc = "Files (fzf-lua)" })
map("n", "<leader>fj", "<cmd>FzfLua buffers<cr>",               { desc = "Buffers (fzf-lua)" })
map("n", "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>",  { desc = "Diagnostics Document" })
map("n", "<leader>fD", "<cmd>FzfLua diagnostics_workspace<cr>", { desc = "Diagnostics Workspace" })
map("n", "<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>",  { desc = "Document Symbols" })
map("n", "<leader>fo", "<cmd>FzfLua resume<cr>",                { desc = "Resume fzf" })
map("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>",             { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>FzfLua grep_curbuf<cr>",           { desc = "Grep Current Buffers" })
map("n", "<leader>fr", "<cmd>FzfLua lsp_references<cr>",        { desc = "LSP References" })
map("n", "<leader>fw", "<cmd>FzfLua grep_cword<cr>",            { desc = "Grep word" })
map("n", "<leader>fW", "<cmd>FzfLua grep_cWORD<cr>",            { desc = "Grep C-WORD" })
map("n", "<leader>fk", "<cmd>FzfLua keymaps<cr>",               { desc = "Keymaps" })
map("n", "<leader>fn", show_messages,                           { desc = "Messages" })
map("n", "<leader>ft", show_tree,                               { desc = "File tree" })
-- stylua: ignore end
