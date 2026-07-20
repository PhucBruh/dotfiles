local ts = require("nvim-treesitter")

ts.setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

local parsers = {
  "bash",
  "css",
  "go",
  "gomod",
  "gosum",
  "html",
  "http",
  "javascript",
  "json",
  "latex",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "rust",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

ts.install(parsers)

vim.api.nvim_create_autocmd("FileType", {
  pattern = parsers,
  callback = function(ev)
    vim.treesitter.start(ev.buf)
  end,
})
