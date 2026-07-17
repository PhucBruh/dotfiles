local on_attach = function(_, bufnr)
  local fzf = require("fzf-lua")
  local maps = vim.keymap.set

  maps("n", "gd", function()
    fzf.lsp_definitions({ jump1 = true, ignore_current_line = true })
  end, { buffer = bufnr, desc = "Goto Definition" })

  maps("n", "grr", function()
    fzf.lsp_references({ jump1 = true, ignore_current_line = true })
  end, { buffer = bufnr, desc = "References" })

  maps("n", "gri", function()
    fzf.lsp_implementations({ jump1 = true, ignore_current_line = true })
  end, { buffer = bufnr, desc = "Implementations" })

  maps("n", "grt", function()
    fzf.lsp_typedefs({ jump1 = true, ignore_current_line = true })
  end, { buffer = bufnr, desc = "Type Definitions" })
end

vim.lsp.config("*", { on_attach = on_attach })

-- Lua
vim.lsp.config("lua_ls", {
  settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})
vim.lsp.enable("lua_ls")

-- Python
vim.lsp.config("pyrefly", {
  cmd = { "pyrefly", "lsp" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "uv.lock", ".git" },
})
vim.lsp.enable("pyrefly")

-- Typst
vim.lsp.config("tinymist", {
  cmd = { "tinymist" },
  filetypes = { "typst" },
  settings = { formatterMode = "typstyle" },
})
vim.lsp.enable("tinymist")

-- Rust
vim.g.rustaceanvim = {
  tools = { float_win_config = { border = "rounded" } },
  server = { on_attach = on_attach },
}

vim.lsp.enable("nixd")

require("conform").setup({
  format_on_save = {
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_format", "ruff_organize_imports" },
    nix = { "nixfmt" },
  },
})
