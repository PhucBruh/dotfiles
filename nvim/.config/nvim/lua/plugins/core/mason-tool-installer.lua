return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  depencies = {
    "williamboman/mason.nvim",
  },
  config = function()
    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettierd",

        -- c++
        "clangd",
        "clang-format",

        -- lua
        "lua-language-server",
        "stylua",

        -- webdev
        "css-lsp",
        "html-lsp",
        "emmet-ls",

        "js-debug-adapter",

        -- svelte
        "svelte-language-server",

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
