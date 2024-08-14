return {
  "stevearc/conform.nvim",
  opts = {
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },

    formatters_by_ft = {
      lua = { "stylua" },
      json = { "jq" },
      markdown = { "prettierd" },
      hmtl = { "prettierd" },
      xml = { "prettierd" },
      graphql = { "prettierd" },
      python = { "ruff" },
      go = { "goimports" },
    },
  },
}
