return {
  "jay-babu/mason-null-ls.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "nvimtools/none-ls.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    ensure_installed = {
      -- lua
      "stylua",

      -- json
      "jq",
      "prettierd",

      -- python
      "ruff",
    },
  },
}
