require("markdown-plus").setup({})
require("render-markdown").setup({
  file_types = {
    "markdown",
    "kulala_ui",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(ev)
    vim.keymap.set({ "n", "i" }, "<C-j>", "<CR>", {
      buffer = ev.buf,
      remap = true,
      desc = "Markdown Enter",
    })
  end,
})
