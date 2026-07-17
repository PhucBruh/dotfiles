require("nvim-treesitter").setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

require("nvim-treesitter").install({
  "lua",
  "go",
  "gomod",
  "gosum",
  "javascript",
  "typescript",
  "tsx",
  "html",
  "css",
  "http",
  "json",
  "yaml",
  "toml",
  "markdown",
  "markdown_inline",
  "bash",
  "python",
  "rust",
  "vim",
  "vimdoc",
  "query",
  "latex",
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
