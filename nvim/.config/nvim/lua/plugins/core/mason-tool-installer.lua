return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  depencies = {
    "williamboman/mason.nvim",
  },
  config = function()
    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettierd",

        -- lua
        "lua-language-server",
        "stylua",

        -- webdev
        "css-lsp",
        "html-lsp",
        "emmet-ls",

        "js-debug-adapter",

        -- python
        "pyright",
        "black",
        "debugpy",

        -- rust
        "codelldb",

        -- toml
        "taplo",
      },
    })
  end,
}
