vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

vim.lsp.enable("lua_ls")

vim.lsp.config("pyrefly", {
  cmd = { "pyrefly", "lsp" },

  filetypes = { "python" },

  root_markers = {
    "pyproject.toml",
    "uv.lock",
    ".git",
  },
})

vim.lsp.enable("pyrefly")

vim.lsp.enable("rust_analyzer")
