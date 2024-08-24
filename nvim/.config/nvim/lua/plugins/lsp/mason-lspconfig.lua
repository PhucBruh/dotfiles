return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = { "williamboman/mason.nvim" },
  opts = {
    ensure_installed = {
      -- lua
      "lua_ls",

      -- json
      "jqls",

      -- toml
      "taplo",

      -- python
      "basedpyright",

      -- webdev
      "cssls",
      "html",
      "emmet_ls",

      -- svelte
      "svelte",
    },
  },
}
