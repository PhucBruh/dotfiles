local map = vim.keymap.set

map("n", "<space>", "<Nop>")

map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down & center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up & center" })
map("v", "<Leader>p", '"_dP', { desc = "Paste without overwriting" })
map({ "n", "x" }, "<Leader>y", [["+y]], { desc = "Yank to system clipboard" })

map("n", "<C-Up>", "<cmd>resize +5<CR>", { desc = "Increase height" })
map("n", "<C-Down>", "<cmd>resize -5<CR>", { desc = "Decrease height" })
map("n", "<C-Right>", "<cmd>vertical resize +5<CR>", { desc = "Increase width" })
map("n", "<C-Left>", "<cmd>vertical resize -5<CR>", { desc = "Decrease width" })

-- save / quit
map("x", "k", "k")
map("n", "<Leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<Leader>W", "<cmd>silent! update | redraw<cr>", { desc = "Force write" })
map("n", "<Leader>q", "<cmd>confirm q<cr>", { desc = "Quit Window" })
map("n", "<Leader>Q", "<cmd>confirm qall<cr>", { desc = "Exit" })

map("n", "<C-Q>", "<cmd>q!<cr>", { desc = "Force quit" })

local function buf_close(force)
  if force then
    vim.cmd("bd!")
  else
    vim.cmd("bd")
  end
end

map("n", "<Leader>c", function()
  buf_close(false)
end, { desc = "Close buffer" })

map("n", "<Leader>C", function()
  buf_close(true)
end, { desc = "Force close buffer" })

map("n", "<C-c>", vim.cmd.nohlsearch, { desc = "Clear search highlight", silent = true })

-- indent movement
map("x", "<C-h>", "<gv")
map("x", "<C-l>", ">gv")

-- move selection
map("x", "<C-j>", "<Cmd>move '>+1<CR>gv=gv")
map("x", "<C-k>", "<Cmd>move '<-2<CR>gv=gv")
