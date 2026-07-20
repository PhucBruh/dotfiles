local autocmd = vim.api.nvim_create_autocmd

-- Highlight yank
autocmd("TextYankPost", {
  desc = "Highlight when yanking",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

autocmd("BufReadPost", {
  desc = "Restore last cursor position",
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(ev.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

autocmd({ "WinEnter", "BufEnter" }, {
  callback = function()
    vim.wo.cursorline = true
  end,
})

autocmd("WinLeave", {
  callback = function()
    vim.wo.cursorline = false
  end,
})
