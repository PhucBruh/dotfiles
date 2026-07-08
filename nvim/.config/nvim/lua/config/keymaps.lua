local map = vim.keymap.set

map("n", "<space>", "<Nop>")

map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down & center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up & center" })
map("v", "<Leader>p", '"_dP', { desc = "Paste without overwriting" })
map("x", "y", [["+y]], { desc = "Yank to system clipboard", silent = true })

map("n", "<C-Up>", "<cmd>resize +5<CR>", { desc = "Increase height" })
map("n", "<C-Down>", "<cmd>resize -5<CR>", { desc = "Decrease height" })
map("n", "<C-Right>", "<cmd>vertical resize +5<CR>", { desc = "Increase width" })

-- Insert mode cursor movement
map("i", "<C-d>", "<Left>", { desc = "Move cursor left" })
map("i", "<C-f>", "<Right>", { desc = "Move cursor right" })

-- save / quit
map("x", "k", "k")
map("n", "<Leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<Leader>q", "<cmd>confirm q<cr>", { desc = "Quit Window" })
map("n", "<Leader>Q", "<cmd>confirm qall<cr>", { desc = "Exit" })

map("n", "<C-S>", "<cmd>silent! update | redraw<cr>", { desc = "Force write" })
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

local function nav(wincmd, dir)
  local prev = vim.api.nvim_get_current_win()
  vim.cmd("wincmd " .. wincmd)
  if vim.api.nvim_get_current_win() ~= prev then
    return -- moved within Neovim
  end
  -- At a split edge: cross into the surrounding multiplexer.
  if vim.env.HERDR_PANE_ID and vim.env.HERDR_PANE_ID ~= "" then
    local herdr = vim.env.HERDR_BIN_PATH
    if herdr == nil or herdr == "" then
      herdr = "herdr"
    end
    vim.fn.system({ herdr, "pane", "focus", "--direction", dir, "--current" })
  elseif vim.env.TMUX and vim.env.TMUX ~= "" then
    local tmux = { left = "Left", down = "Down", up = "Up", right = "Right" }
    pcall(vim.cmd, "TmuxNavigate" .. tmux[dir])
  end
end

local function map(lhs, wincmd, dir, desc)
  vim.keymap.set("n", lhs, function()
    nav(wincmd, dir)
  end, { silent = true, noremap = true, desc = desc })
end

map("<M-h>", "h", "left", "Navigate left (vim/herdr)")
map("<M-j>", "j", "down", "Navigate down (vim/herdr)")
map("<M-k>", "k", "up", "Navigate up (vim/herdr)")
map("<M-l>", "l", "right", "Navigate right (vim/herdr)")
