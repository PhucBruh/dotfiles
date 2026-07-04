require("conform").setup({
  format_on_save = {
    lsp_format = "fallback",
  },

  formatters_by_ft = {
    lua = { "stylua" },

    python = {
      "ruff_format",
      "ruff_organize_imports",
    },
  },
})
